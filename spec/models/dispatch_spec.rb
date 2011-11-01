require 'spec_helper'

describe "dispatch" do
  # Common code
  let(:player) do
    FactoryGirl.create(:player)
  end
  before(:each) do
    player # don't lazy load the player!
  end

  describe "Look Command" do
    it "Should have a command to look." do
      room = player.room
      player.process_input("look")
      player.should have_output "#{room.name}\n#{room.desc}\nYou see no exits.\n"
    end
    it "Shouldn't crash if there are multiple exits"
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
    player.log_in! con
    player.should_receive(:log_out!)
    player.process_input("quit")
  end

  it "Should let the player say things"
  context "Movement" do
    let(:other_room) do
      FactoryGirl.create(:room)
    end
    it "if there is a standard exit name, it should let the player use it wth the full exit name." do
      player.room.exits.create(:direction => 'north', :destination => other_room)
      player.process_input("north")
      player.room.should == other_room
    end
    it "if there is a standard exit name, it should let the player use it wth the abbreviated exit name." do
       player.room.exits.create(:direction => 'north', :destination => other_room)
       player.process_input("n")
       player.room.should == other_room
    end
    it "if the standard exit doesn't exist, it should give the player a 'no exit' message" do
       player.process_input("north")
       player.pending_output.should =~ /can't go/
    end
    it "if a custom exit exists, then the player should be able to go that way." do
      player.room.exits.create(:direction => 'abcde', :destination => other_room)
      player.process_input("abcde")
      player.room.should == other_room
    end
    it "if a custom exit doesn't exist, it should give the player a 'I don't know what you mean' message" do
      player.process_input("abcde")
      player.pending_output.should =~ /don't/
    end
  end
  
  it "Should let the player see who is online."

  it "Should allow the player to view their inventory."

end
