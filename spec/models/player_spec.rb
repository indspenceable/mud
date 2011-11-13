# == Schema Information
#
# Table name: players
#
#  id             :integer         not null, primary key
#  name           :string(255)     not null
#  password_hash  :string(255)
#  password_salt  :string(255)
#  pending_output :string(255)
#  logged_in      :boolean
#  room_id        :integer         not null
#  colors         :text            not null
#  exp            :integer         default(0), not null
#  hp             :integer
#  mp             :integer
#  left_hand_id   :integer
#  right_hand_id  :integer
#

require 'spec_helper'

describe Player do
  let(:player) do
    p = FactoryGirl.create(:player)
  end
  it "should be able to produce output when logged in." do
    con = mock('connection')

    player.log_in! con
    #We give it this regex because the prompt may change.
    con.should_receive(:send_data).with(/\AHello.*/)
    player.output("Hello")
    player.deliver_output
  end

  it "should test the prompt"

  it "should be able to log in and out" do
    con = mock('connection')
    player.log_in! con
    player.logged_in?.should be true
    con.should_receive(:close_connection_after_writing)
    con.should_receive(:send_data).with(/Goodbye!/)
    player.log_out!
    player.logged_in?.should be false
  end

  it "Should deliver all output at once" do
    con = mock('connection')

    player.log_in! con
    player.output("a")
    player.output("b")
    player.output("c")
    con.should_receive(:send_data).with(/\Aa\nb\nc\n.*/)
    player.deliver_output
  end

  it "Should be able to produce output in color" do
    con = mock('connection')
    player.log_in! con
    player.output("a", :color => :test1)
    player.output("b", :color => :test2)
    #TODO - UGH. Clean this shit up.s
    con.should_receive(:send_data).with(/\A\e\[31ma\e\[0m\n\e\[34mb\e\[0m\n/)
    player.deliver_output
  end
end


