require 'unbound_connection'

module Mud
  class PlayerConnection < EM::Connection
    def post_init
      @unbound = Unbound.new self
    end

    def unbind
      if @player
        p = Player.find(@player)
        p.log_out! if p.logged_in #examine the ATTRIBUTE not the method.
        p.remove_connection!
      end
    end

    def receive_data data
      @player ? Player.find(@player).process_input(data.chomp) : @player = @unbound.process_input(data.chomp)
    end
  end
end
