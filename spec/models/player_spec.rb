require 'spec_helper'

describe Player do
  before(:each) do
    begin
      @player = FactoryGirl.build(:player)
    rescue Object => o
      puts o
    end
  end
  it "should be able to produce output when logged in." do
    con = mock('connection')

    @player.log_in con
    con.should_receive(:send_data).with("Hello\n")
    @player.output("Hello")
    @player.deliver_output
  end

  it "should be able to log in and out" do
    con = mock('connection')
    @player.log_in con
    @player.logged_in?.should be true
    con.should_receive(:close_connection_after_writing)
    @player.log_out
    @player.logged_in?.should be false
  end

  it "Should deliver all output at once" do
    con = mock('connection')

    @player.log_in con
    @player.output("a")
    @player.output("b")
    @player.output("c")
    con.should_receive(:send_data).with("a\nb\nc\n")
    @player.deliver_output
  end

  it "Should be able to produce output in color" do
    con = mock('connection')
    @player.log_in con
    @player.output("a", :color => :test1)
    @player.output("b", :color => :test2)
    con.should_receive(:send_data).with("\e[31ma\e[0m\n\e[34mb\e[0m\n")
    @player.deliver_output
  end
end
