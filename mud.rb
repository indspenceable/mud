#! ruby

require File.expand_path('../config/environment',  __FILE__)


EM::run do
  EM::start_server '0.0.0.0', 8080, Mud::PlayerConnection
  EM::PeriodicTimer.new(3) do
    Mobile.all.each do |m|
      m.take_action
    end
  end
  EM::PeriodicTimer.new(0) do 
    Player.where('pending_output IS NOT NULL').each do |p|
      p.deliver_output if p.logged_in?
    end
  end
  puts "started server on 0.0.0.0:8080"
end
