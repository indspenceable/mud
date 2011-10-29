#MAKE SOME PLAYERS. TASTY.
require './script/seed_rooms'

Player.create(:name => 'Danny', :room => Room.first, :command_groups => [CommandGroup.find_or_create_by_name('gunslinger')])
Player.create(:name => 'Lindsay', :room => Room.first, :command_groups => [CommandGroup.find_or_create_by_name('builder')])