#MAKE SOME ROOMS.
crossroads = Room.create(:name => "The crossroads", :desc => "You are at the crossroads.")
northroads = Room.create(:name => "The northroad", :desc => "A long and dusty road. The rotten stench of eggs hangs in the air.")
crossroads.exits.create(:direction => 'north', :destination => northroads)
northroads.exits.create(:direction => 'south', :destination => crossroads)