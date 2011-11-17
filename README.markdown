# MUD

This is the code for a mud, written in Ruby. Persistant data is stored with activerecord, and almost everything is interacted with through a model of some sort.

## Running the game

Just `ruby server.rb` - this will spawn the main eventmachine loop.

## Layout

This is a fairly standard mud setup - there are `Players` and NPC `Mobiles` who are located in `Rooms`. `Items` can be located in rooms, or held by players or mobiles. Players additionally can have `Buffs` and `Debuffs`. When a player gets input, it is compared against the names of its command groups (players get "default" for free), and the names of the commands held within that group.

A lot of multi-table inheritance is needed for having different types of mobiles. To facilitate this, the `owns_one` relationship automatically forwards methods for a delegate table's attributes to the owner. For example, if you have `MobileA < Mobile`, and it needs to have the attribute `feelings (string)` but no other mobiles need this, you would create another model (and table) MobileADelegate, and do `owns_one :mobile_a, "MobileADelegate"` in MobileA. All of the base tables which might need this functionality already implement a helper to make this easy (for instance, Item defines `self.item_delegate`)