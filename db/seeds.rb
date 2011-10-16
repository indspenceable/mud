# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "------- Seeding Database"

#MAKE SOME ROOMS.
crossroads = Room.create(:name => "The crossroads", :desc => "You are at the crossroads.")
northroads = Room.create(:name => "The northroad", :desc => "A long and dusty road. The rotten stench of eggs hangs in the air.")
crossroads.exits.create(:direction => 'north', :destination => northroads)
northroads.exits.create(:direction => 'south', :destination => crossroads)

default = CommandGroup.create(:name => 'default')

#MAKE SOME SKILLS
C::Drop.create.command_names.create(:command_group => default, :name => 'drop')
C::Exit.create.command_names.create(:command_group => default, :name => 'exit')
C::Get.create.command_names.create(:command_group => default, :name => 'get')
C::Inventory.create.command_names.create(:command_group => default, :name => 'i')
C::Look.create.command_names.create(:command_group => default, :name => 'look')
C::Quit.create.command_names.create(:command_group => default, :name => 'quit')
C::Say.create.command_names.create(:command_group => default, :name => 'say')
C::Who.create.command_names.create(:command_group => default, :name => 'who')

#MAKE SOME PLAYERS. TASTY.
Player.create!(:name => 'Danny', :room => crossroads)
Player.create(:name => 'Lindsay', :room => crossroads)

puts "------- Finished Seeding"
