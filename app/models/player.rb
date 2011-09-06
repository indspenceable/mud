require 'command_parser'
class Player < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :owner
  has_many :extrinsics

  def effects
    extrinsics
  end
  def attr_apply sym, val
    send sym, effects.reduce(val){|memo, obj| obj.klass.send(sym,memo)}
  end

  def self.chain sym
    new_name = :"direct_#{sym}"
    alias_method new_name, sym
    define_method sym, ->(value) do 
      self.send new_name, effects.reduce(value) { |memo, obj| obj.klass.respond_to?(sym)?  obj.klass.send(sym,memo) : memo }
    end
  end

  def take_damage n
    puts "You took #{n} damage!"
  end
  self.chain :take_damage

  #input/output
  def process_input command
    Commands::parse(self, command)
  end
  self.chain :process_input

  def output text
    update_attribute(:pending_output, (pending_output ? pending_output + text : text) + "\n")
  end
  self.chain :output

  #login/logout
  def logged_in?
    CONNECTIONS.key? id
  end
  def logout
    CONNECTIONS[id].close_connection_after_writing
  end
end
