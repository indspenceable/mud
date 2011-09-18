#! ruby

require File.expand_path('../config/environment',  __FILE__)


EM::run do
  EM::start_server '0.0.0.0', 8080, Mud::PlayerConnection
  EM::PeriodicTimer.new(3) do 
    Player.all.each {|p| p.output("TIMER.")}
  end
  puts "started server on 0.0.0.0:8080"
end
