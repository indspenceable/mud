require 'dispatch'
class Player < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :owner
  has_many :buffs
  serialize :colors, Hash
  
  validate :colors, :presence => true
  validate :room, :presence => true
  
  has_and_belongs_to_many :command_groups

  def command_names
    CommandName.where(:command_group_id => command_groups)
  end
  
  before_create do
    self.colors ||= Player::default_colors
  end
  after_create do
    command_groups << CommandGroup.find_by_name('default')
  end
  before_save do
    name.downcase!
  end

  def colorize category
    Player::color_code colors[category]
  end

  def self.default_colors
    {
      :name => :red,
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

  def self.chain sym
    new_name = :"direct_#{sym}"
    alias_method new_name, sym
    define_method sym, ->(*value) do 
      self.send new_name, *buffs.reduce(value) { |memo, obj| obj.klass.respond_to?(sym)?  obj.klass.send(sym,*memo) : memo }
    end
  end

  #input/output
  def process_input input
    input = "say #{input[1,input.length]}" if input[0]=='"' || input[0]=="'"
    input=~(/\A(\w*)\s*(.*)?\z/)
    command_name,arguments = $1,$2

    # is there a command with that name that I have access to?
    command = command_names.find_by_name($1).command rescue nil
    if command
      command.perform self, $2
    else
      output("I don't quite know what you mean by that.")
    end
  rescue Object => e
    raise e unless Rails.env.production?
      
    puts "Triggered Exception"
    puts e
    puts "***********"
    puts e.backtrace
    output("You've triggered an uncaught exception. That's too bad. Please don't do that again, for the immediate time being? Thanks!")
  end
  self.chain :process_input

  def output text, opts = {}
    opts = {:newline => true}.merge(opts)
    text = "#{colorize(opts[:color])}#{text}#{Player::color_code :reset}" if opts[:color]
    text = text + "\n" if opts[:newline]
    update_attribute(:pending_output, (pending_output ? pending_output + text : text))
    #deliver_output if logged_in?
  end
  self.chain :output

  #login/logout
  def log_in con
    CONNECTIONS[id] = con
  end
  def logged_in?
    CONNECTIONS.key? id
  end
  def self.logged_in
    CONNECTIONS.keys.map{|pid| Player.find(pid)}
  end
  def log_out
    room.echo("#{name} glows softly, and then vanishes.", self)
    output("Goodbye!")
    CONNECTIONS[id].close_connection_after_writing
    CONNECTIONS.delete(id)
  end
  def deliver_output
    CONNECTIONS[id].send_data pending_output
    update_attribute :pending_output, nil
  end
end
