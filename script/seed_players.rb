#MAKE SOME PLAYERS. TASTY.
require './script/seed_rooms'

Player.create!(:name => 'Danny', :room => Room.first)
Player.create(:name => 'Lindsay', :room => Room.first)