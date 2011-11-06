#! ruby

puts "Loading environment"
require File.expand_path('../config/environment',  __FILE__)

# If we're starting the server, no players should be logged in.
puts "Initializing all players to be logged out."
Player.where(:logged_in => true).each do |p|
  puts "Updating a player."
  p.update_attributes!(:logged_in => false)
end
puts Player.where(:logged_in => true).count

puts "Starting EM"
EM::run do
  EM::start_server '0.0.0.0', 8080, Mud::PlayerConnection
  EM::PeriodicTimer.new(0) do
    Mobile.all.each do |m|
      m.take_action
    end
    Player.where('logged_in = "t" AND pending_output IS NOT NULL').each do |p|
      p.deliver_output
    end
    BalanceUse.where("ending_at < ?", Time.zone.now).each do |b|
      b.destroy
    end
  end
  
  puts "started server on 0.0.0.0:8080"
end
