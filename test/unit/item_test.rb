# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  owner_id   :integer         not null
#  owner_type :string(255)     not null
#  type       :string(255)     not null
#

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

