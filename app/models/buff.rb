# == Schema Information
#
# Table name: buffs
#
#  id         :integer         not null, primary key
#  player_id  :integer         not null
#  type       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

class Buff < ActiveRecord::Base
  belongs_to :player
  validate :player, :presence => true
  
  has_many :data_fields
end

