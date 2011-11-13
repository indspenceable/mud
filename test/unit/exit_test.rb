# == Schema Information
#
# Table name: exits
#
#  id             :integer         not null, primary key
#  direction      :string(255)     not null
#  origin_id      :integer         not null
#  destination_id :integer         not null
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class ExitTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


