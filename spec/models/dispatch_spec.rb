require 'spec_helper'

describe Dispatch do
  before(:each) do
    @player = FactoryGirl.build(:player)
  end

  it "Should have a command to look."
  it "Should have a command to drop items."
  it "Should have a command to get items."
  it "Should have a command to look its your inventory."
  it "Should let the player quit"
  it "Should let the player say things"
  it "Should let the player move."
  it "Should let the player see who is online."
end
