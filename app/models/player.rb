# == Schema Information
#
# Table name: players
#
#  id             :integer         not null, primary key
#  name           :string(255)     not null
#  password_hash  :string(255)
#  password_salt  :string(255)
#  pending_output :string(255)
#  logged_in      :boolean
#  room_id        :integer         not null
#  colors         :text            not null
#  exp            :integer         default(0), not null
#  hp             :integer
#  mp             :integer
#  left_hand_id   :integer
#  right_hand_id  :integer
#

class Player < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :owner
  has_many :buffs
  serialize :colors, Hash
  has_many :balance_uses
  
  belongs_to :left_hand, :class_name => "Item"
  belongs_to :right_hand, :class_name => "Item"
  
  
  validate :colors, :presence => true
  validate :room, :presence => true
  validate :name, :presence => true, :uniqueness => true
  before_validation :remove_unowned_items_from_slots
  
  def remove_unowned_items_from_slots
    #for all slots, they must either be empty, or be owned by this player.
    [:left_hand,:right_hand].each do |current_slot|
      item = send(current_slot)
      self.update_attribute(current_slot, nil) if item && (item.owner != self)
    end
  end
  
  scope :logged_in, where(:logged_in => true)
  
  has_and_belongs_to_many :command_groups
  def command_names
    CommandName.where(:command_group_id => command_groups)
  end
  before_create do
    self.hp = max_hp
    self.mp = max_mp
    self.colors ||= Player::Colors.default_colors
  end
  after_create do
    command_groups << CommandGroup.find_by_name('default')
  end
  before_save do
    name.downcase!
  end
  def self.chain *syms
    syms.each do |sym|
      new_name = :"direct_#{sym}"
      alias_method new_name, sym
      define_method sym, ->(*value) do 
        self.send new_name, *buffs.reduce(value) { |memo, obj| obj.klass.respond_to?(sym)?  obj.klass.send(sym,*memo) : memo }
      end
    end
  end

  #COLORS
  module Colors
    def colorize category
      Player::Colors.color_code colors[category]
    end
    def self.default_colors
      {
        :title => :red,
        :players => :blue,
        :exits => :yellow,
        :say => :cyan,
        :end => :reset
      }
    end
    @@color_codes ={
      :red => "\e[31m",
      :blue => "\e[34m",
      :cyan => "\e[36m",
      :yellow => "\e[33m",
      :reset =>"\e[0m"
    }
    def self.color_code color
      @@color_codes[color]
    end
  end
  include Colors

  #TODO does this live here?
  module Exits
    def self.valid_standard_exit? dir
      exit_names[dir] or (dir if exit_names.values.include? dir)
    end
    def self.exit_names
      @@exit_names ||= {'n'=>'north','s'=>'south','e'=>'east','w'=>'west','nw'=>'northwest','sw'=>'southwest','se'=>'southeast','ne'=>'northeast'}
    end
    def parse_direction cmd, args
      # If command is a standard exit name set exit_dir to that
      exit_dir = Player::Exits.exit_names.values.include?(cmd)? cmd : Player::Exits.exit_names[cmd]
      # find the exit for that direction, if it exists
      exit_obj = room.exits.find_by_direction (exit_dir || cmd)
      # if it is either a standard exit name, OR we found an exit for a special name
      if exit_dir || exit_obj
        res = command_names.find_by_name('exit').command.perform_with_balance_check self, (exit_dir || cmd) rescue nil
        #output "There's no exit in that direction" unless res
        true
      end
    end
  end
  include Exits

  module InputOutput
    #input/output
    def process_input input
      input = "say #{input[1,input.length]}" if input[0]=='"' || input[0]=="'"
    
      command_name,arguments = input.split(' ', 2)
      # if there's an exit with this name...
      return if parse_direction command_name, arguments

      #command_name, arguments = "exit", input if room.exits.find_by_direction(command_name)
      #command_name, arguments = "exit", parse_direction(command_name) if 

      #Global namespace'd command
      command = command_names.find_by_name(command_name).command rescue nil
      return command.perform_with_balance_check self, arguments if command
      #nested namespace command
      group_name, command_name, arguments = command_name, 'goto', 1
      command = command_groups.find_by_prefix(group_name).commands.find_by_name(command_name) rescue nil
      return command.perform self, arguments if command
 
      output "I don't quite know what you mean by that."
    rescue Object => e
      raise e unless Rails.env.production?
      
      puts "Triggered Exception"
      puts e
      puts "***********"
      puts e.backtrace
      output("You've triggered an uncaught exception. That's too bad. Please don't do that again, for the immediate time being? Thanks!")
    end

    def output text, opts = {}
      opts = {:newline => true}.merge(opts)
      text = "#{colorize(opts[:color])}#{text}#{Player::Colors.color_code :reset}" if opts[:color]
      text = text + "\n" if opts[:newline]
      update_attributes!(:pending_output => (pending_output ? pending_output + text : text))
      nil
    end
    
    
    def prompt
      "[#{hp}/#{max_hp}   #{has_balance?(:balance) ? 'x' : '-'}]"
    end
    #Only call if we are logged in
    def deliver_output
      connections[id].send_data pending_output + prompt
      update_attributes! :pending_output => nil
    end
  end
  include InputOutput
  chain :output, :process_input


  #login/logout
  module Connections
    def connections
      @@connections ||= {}
    end
  
    def log_in! con
      connections[id] = con
      update_attributes!(:logged_in => true)
    end
    def log_out!
      room.echo("#{name} glows softly, and then vanishes.", self)
      output("Goodbye!")
      deliver_output
      connections[id].close_connection_after_writing
      update_attributes!(:logged_in => false)
    end
    def remove_connection!
      connections.delete(id)
    end
  end
  include Connections

  # Balance stuff
  module Balance
    def off_balance? balance_type
      balance_uses.find_by_balance_type(balance_type)
    end
    def has_balance? balance_type
      !off_balance?(balance_type)
    end

    def use_balance! balance_type, time_in_seconds
      BalanceUse.find_or_create_by_player_id_and_balance_type(:player_id => self.id, :balance_type => balance_type, :ending_at => Time.now) do |bu|
        bu.ending_at += time_in_seconds.seconds
      end
    end
    BALANCE_MESSAGES = {
      balance:'You have regained balance.',
      equilibrium:'You have regained equilibrium'
    }
    def regain_balance balance_type
      output(BALANCE_MESSAGES[balance_type] || "You have regained #{balance_type}")
    end
  end
  include Balance
  
  #Sub modules for HP/MP
  module Experience
    #THE MAGIC FORMULA
    def level
      (Math.sqrt(exp)/3).floor() + 1
    end
    def max_mp
      60*level
    end
  end
  include Experience
  
  module Health
    def max_hp
      60*level
    end
    def take_damage! damage
      update_attributes!(:hp => hp - damage)
      die! if self.hp <= 0
    end
    def die!
      output "You have died."
      room.echo "#{name} has died. What a loser!", self
      update_attributes!(:hp => max_hp)
    end
  end
  include Health
  
  module Gender
    def he
      'He'
    end
    def she
      he
    end
    def his
      'his'
    end
    def hers
      his
    end
    def him
      'him'
    end
    def her
      him
    end
  end
  include Gender
  
  module Descriptions
    def short_name
      name.capitalize
    end
    def long_name
      rtn = "#{short_name} is here. "
      puts "Left hand is #{left_hand} and right hand is #{right_hand}"
      if left_hand || right_hand
        rtn << "#{he} is holding "
        rtn << "#{left_hand.short_name} in #{his} left hand#{', and ' if right_hand}" if left_hand
        rtn << "#{right_hand.short_name} in #{his} right hand" if right_hand
        rtn << "."
      end
      rtn
    end
  end
  include Descriptions
end


