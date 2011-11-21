#! ruby

puts "Loading environment"
require File.expand_path('../config/environment',  __FILE__)

# If we're starting the server, no players should be logged in.
puts "Initializing all players to be logged out."
Player.initialize_all_players_as_logged_out!
puts Player.where(:logged_in => true).count

puts "Starting EM"
EM::run do
  EM::start_server '0.0.0.0', 8080, Mud::PlayerConnection
  EM::PeriodicTimer.new(0) do
    Mobile.all.each(&:take_action)
    Player.deliver_output_to_all_logged_in_players
    BalanceUse.destroy_expired
    Buff.destroy_expired
  end
  
  EM::PeriodicTimer.new(3) do
    Buff.where(:needs_pulse => true).all.each(&:pulse)
  end
  
  puts "started server on 0.0.0.0:8080"
end
