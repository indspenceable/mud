require 'spec_helper'

describe Test do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "should be able to produce output when logged in." do
    con = mock('connection')
    CONNECTIONS[Player.first.id] = con
    con.should_recieve(:send_data).with("Hello\n")
    Player.first.output("Hello")
  end
end
