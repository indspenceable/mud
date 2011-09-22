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

end
