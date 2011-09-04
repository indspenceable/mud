require File.expand_path('../../config/environment',  __FILE__)
require 'mud_setup'
require 'player_connection'

EM::run do
  EM::start_server '0.0.0.0', 8080, Mud::PlayerConnection do
    EM::PeriodicTimer.new(0) do
      OUTPUT_BUFFERS.each do |key,value|
        CONNECTIONS[key].send_data(value) if value != ""
      end
      OUTPUT_BUFFERS.clear
    end
  end
end
