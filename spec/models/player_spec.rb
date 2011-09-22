require 'spec_helper'

describe Test do
  before(:each) do
    @player = FactoryGirl.build(:player)
  end
  it "should be able to produce output when logged in." do
    con = mock('connection')

    CONNECTIONS[@player.id] = con

    con.should_receive(:send_data).with("Hello\n")
    @player.output("Hello")
    @player.deliver_output
  end

  it "Should be logged in only when there is a connection associated with it." do
    CONNECTIONS[@player.id] = true
    @player.logged_in?.should be true
    CONNECTIONS.delete(@player.id)
    @player.logged_in?.should be false
  end

  it "Should deliver all output at once" do
    con = mock('connection')

    CONNECTIONS[@player.id] = con

    con.should_receive(:send_data).with("a\nb\nc\n")
    @player.output("a")
    @player.output("b")
    @player.output("c")
  end

  it "Should be able to produce output in color"
end
