require 'spec_helper'

describe "Gunslinger" do
  let(:player) do
     FactoryGirl.create(:player)
  end
  before(:each) do
     # Player can use builder commands.
     player.command_groups << CommandGroup.find_by_name('gunslinger')
  end
   
  describe "Fire" do
    it "should not raise an error with no arguments"
    it "should not raise an error if it cann't find the target"
    it "Shouldn't happen if the player is off any standard balance (This should be in a shared test for commands)"
    it "Should take its effect if the player is on balance and there is a proper target."
  end
end