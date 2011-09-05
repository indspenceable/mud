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
  end

  #login/logout
  def logged_in?
    CONNECTIONS.key? id
  end
  def logout
    CONNECTIONS[id].close_connection_after_writing
  end
end
