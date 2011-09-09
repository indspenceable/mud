#! ruby

require File.expand_path('../config/environment',  __FILE__)
require 'logging'
require 'mud_setup'
require 'player_connection'

EM::run do
  EM::start_server '0.0.0.0', 8080, Mud::PlayerConnection
  puts "started server on 0.0.0.0:8080"
end
