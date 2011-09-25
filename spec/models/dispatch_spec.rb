require 'spec_helper'

describe Dispatch do
  before(:each) do
    @player = FactoryGirl.create(:player)
  end

  it "Should have a command to look."
  it "Should have a command to get items." do
    room = @player.room
    item = FactoryGirl.create(:basic_item, :owner => room)
    room.items.should == [item]
    @player.items.should == []

    @player.process_input("get item")

    [room,item,@player].each {|el| el.reload}
    @player.items.should == [item]
    room.items.should == []
  end
  it "Should have a command to drop items."
  it "Should have a command to look its your inventory."
  it "Should let the player quit"
  it "Should let the player say things"
  it "Should let the player move."
  it "Should let the player see who is online."
end
