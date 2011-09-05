#! ruby

require File.expand_path('../config/environment',  __FILE__)
require 'logging'
require 'mud_setup'
require 'player_connection'

EM::run do
  EM::start_server '0.0.0.0', 8080, Mud::PlayerConnection do
    EM::PeriodicTimer.new(0) do
      begin
        Player.where("pending_output IS NOT NULL").each do |player|
          if CONNECTIONS.key? player.id
            CONNECTIONS[player.id].send_data(player.pending_output)
            Log.debug("Sent #{player.name}: #{player.pending_output.chop}")
            player.update_attribute(:pending_output, nil)
          else
            # We could send that output as a message. For now, let's keep it pendinga
          end
        end
      rescue Object => e
        Log.debug "Timer got an error. #{e}"
      end
    end
  end
  puts "started server on 0.0.0.0:8080"
end
