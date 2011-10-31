# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  owner_id   :integer         not null
#  owner_type :string(255)     not null
#  type       :string(255)     not null
#

require 'spec_helper'

shared_examples_for Item do
  pending "add some examples to (or delete) #{__FILE__}"
end

