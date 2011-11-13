# == Schema Information
#
# Table name: rat_delegates
#
#  id         :integer         not null, primary key
#  rat_id     :integer
#  toughness  :integer         default(15), not null
#  created_at :datetime
#  updated_at :datetime
#

class RatDelegate < ActiveRecord::Base
  belongs_to :rat
end


