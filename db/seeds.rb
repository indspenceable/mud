# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "------- Seeding Database"

crossroads = Room.create(:name => "The crossroads", :desc => "You are at the crossroads.")
northroads = Room.create(:name => "The northroad", :desc => "A long and dusty road. The rotten stench of eggs hangs in the air.")
crossroads.exits.create(:direction => 'north', :destination => northroads)
northroads.exits.create(:direction => 'south', :destination => crossroads)

Player.create!(:name => 'Danny', :room => crossroads)
Player.create(:name => 'Lindsay', :room => crossroads)

puts "------- Finished Seeding"
