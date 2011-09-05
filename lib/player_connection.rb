require 'player'
require 'unbound_connection'

module Mud
  class PlayerConnection < EM::Connection
    def post_init
      @unbound = Unbound.new self
    end

    def unbind
      CONNECTIONS.delete(@player) if @player
    end

    def receive_data data
      @player ? Player.find(@player).process_input(data.chomp) : @player = @unbound.process_input(data.chomp)
    end
  end
end
