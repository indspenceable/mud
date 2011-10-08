require 'spec_helper'

describe Dispatch do
  let(:player) do
    FactoryGirl.create(:player)
  end

  it "Should have a command to look." do
    room = player.room
    player.process_input("look")
    player.pending_output.should == "#{room.name}\e[0m\n#{room.desc}\e[0m\nYou see no exits.\e[0m\n"
  end

  it "Should have a command to get items." do
    room = player.room
    item = FactoryGirl.create(:basic_item, :owner => room)
    room.items.should == [item]
    player.items.should == []

    player.process_input("get item")

    [room,item,player].each {|el| el.reload}
    player.items.should == [item]
    room.items.should == []
  end
  it "Should have a command to get items." do
    room = player.room
    item = FactoryGirl.create(:basic_item, :owner => player)
    player.items.should == [item]
    room.items.should == []

    player.process_input("drop item")

    [room,item,player].each {|el| el.reload}
    room.items.should == [item]
    player.items.should == []
  end
  it "Should have a command to look its your inventory."
  it "Should let the player quit" do
    con = mock(:connection)
    player.log_in con
    player.should_receive(:log_out)
    player.process_input("quit")
  end

  it "Should let the player say things" do
  end
  it "Should let the player move."
  it "Should let the player see who is online."

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
end
