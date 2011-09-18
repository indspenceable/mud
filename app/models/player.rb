require 'dispatch'
class Player < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :owner
  has_many :extrinsics
  serialize :colors, Hash

  def effects
    extrinsics
  end
  #def attr_apply sym, val
  #  send sym, effects.reduce(val){|memo, obj| obj.klass.send(sym,memo)}
  #end

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
  def self.color_code color
    @@color_codes ||= {
      :red => "\e[31m",
      :blue => "\e[34m",
      :cyan => "\e[36m",
      :yellow => "\e[33m",
      :reset =>"\e[0m"
    }
    @@color_codes[color]
  end

  def self.chain sym
    new_name = :"direct_#{sym}"
    alias_method new_name, sym
    define_method sym, ->(*value) do 
      self.send new_name, *effects.reduce(value) { |memo, obj| obj.klass.respond_to?(sym)?  obj.klass.send(sym,*memo) : memo }
    end
  end

  def take_damage n
    puts "You took #{n} damage!"
  end
  self.chain :take_damage

  #input/output
  def process_input command
    #Mud::Commands::parse(self, command)
    Dispatch.parse self,command
  end
  self.chain :process_input


  def output text, opts = {}
    opts = {:newline => true}.merge(opts)
    text = "#{colorize(opts[:color])}#{text}#{colorize :end}" if opts[:color]
    text = text + "\n" if opts[:newline]
    update_attribute(:pending_output, (pending_output ? pending_output + text : text))
    deliver_output if logged_in?
  end
  self.chain :output

  #login/logout
  def logged_in?
    CONNECTIONS.key? id
  end
  def logout
    room.echo("#{name} glows softly, and then vanishes.", self)
    output("Goodbye!")
    CONNECTIONS[id].close_connection_after_writing
  end
  def deliver_output
    puts "Pending data is #{pending_output}"
    CONNECTIONS[id].send_data pending_output
    Log.debug("Sent #{name}: #{pending_output.chop}")
    update_attribute :pending_output, nil
  end
end
