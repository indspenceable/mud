require 'player'
module Mud
  class PlayerConnection < EM::Connection
    def post_init
      @state = :fresh
      send_data "Welcome. Please enter a name"
    end

    def receive_data data
      Player.find_by_name(@player).process_input(data.chomp,self) if @player
      self.send(@state,data.chomp)
    end

    def fresh unprocessed_data
      data = unprocessed_data.lowercase
      if Player.exists?(:name => data)
        send_data("logged in as #{data}")
        @player = data
        CONNECTIONS[data]
      else
        send_data "Unable to log in. Try again."
      end
    end

    def send_data data
      super(data+"\n")
    end
  end
end
