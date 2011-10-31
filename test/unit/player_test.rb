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
#

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

