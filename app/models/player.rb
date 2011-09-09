require 'command_parser'
class Player < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :owner

  #input/output
  def process_input command
    Commands::parse(self, command)
  end
  def output text
    update_attribute(:pending_output, (pending_output ? pending_output + text : text) + "\n")
    deliver_output if logged_in?
  end

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
    CONNECTIONS[id].send_data pending_output
    Log.debug("Sent #{name}: #{pending_output.chop}")
    update_attribute :pending_output, nil
  end
end
