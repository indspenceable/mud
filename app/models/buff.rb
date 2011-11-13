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
  
  def self.buff_delegate
    delegate_type = name.match(/Buffs::(.*)/)[1].underscore
    owns_one delegate_type, "Buffs::Delegates::#{delegate_type.camelcase}Delegate"
  end
end

