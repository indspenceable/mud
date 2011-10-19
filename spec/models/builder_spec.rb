require 'spec_helper'

describe "Building commands" do
  let(:player) do
     FactoryGirl.create(:player)
   end
   before(:each) do
     # Player can use builder commands.
     player.command_groups << CommandGroup.find_by_name('builder')
   end
  
  describe "goto command" do
    it "should let the player go to any room" do
      other_room = FactoryGirl.create(:room)
      player.process_input("goto #{other_room.id}")
      player.room.should == other_room
    end
    it "Should display an error if there is no room with that id" do
      current_room = player.room
      player.process_input("goto #{player.room.id + 1}")
      player.room.should == current_room
      player.pending_output.should == "There's no room with that id.\n"
    end
  end
  context "room inspection commands" do
    it "should let a player see what rooms exist" do
      message = "Rooms:\n#{Room.all.map{|r| "#{r.id}: #{r.name}"}.join("\n")}\n"
      player.process_input("rooms")
      player.pending_output.should == message
    end
    it "should let a builder see their current room number with 'bl'" do
      r_id = player.room.id
      player.process_input("bl")
      player.pending_output.should =~ /#{r_id}/
    end
    it "should allow a player to build a room with a title" do
      current_number_of_rooms = Room.all.size
      player.process_input("create_room a brand new room")
      Room.all.size.should == current_number_of_rooms+1
      Room.find_by_name("a brand new room").should_not be_nil
    end
  end
  context "room editing commands" do
    it "should allow a user to change the title of a room with set title" do
      new_title = "not the old title"
      player.process_input("set_title #{new_title}")
      player.room.name.should == new_title
    end
  
    it "should allow a user to change the description of a room with set desc" do
      new_desc = "A very interesting description."
      new_title = "not the old title"
      player.process_input("set_description #{new_desc}")
      player.room.desc.should == new_desc
    end
    context "Modify exits" do
      it "should allow you to remove an exit" do
        other_room = FactoryGirl.create(:room)
        exit = FactoryGirl.create(:exit, :direction => 'north', :origin => player.room, :destination => other_room)
        player.room.exits.size.should == 1
        player.process_input("remove_exit north")
        player.room.exits.size.should == 0
      end
      it "should allow you to create an exit." do
        other_room = FactoryGirl.create(:room)
        player.process_input("create_exit n #{other_room.id}")
        player.room.exits.size.should == 1
      end
      it "Shouldn't do anything if there's no room with that id" do
         other_room = FactoryGirl.create(:room)
         player.process_input("create_exit north #{other_room.id + player.room.id}")
         player.pending_output.should =~ /no room/i
      end
      it "Shouldn't do anything if its an invalid direction" do
        other_room = FactoryGirl.create(:room)
         player.process_input("create_exit qwerty #{other_room.id}")
         player.pending_output.should =~ /valid direction/i
      end
    end
  end
end