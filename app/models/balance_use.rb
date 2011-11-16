# == Schema Information
#
# Table name: balance_uses
#
#  id           :integer         not null, primary key
#  balance_type :string(255)     not null
#  ending_at    :datetime        not null
#  player_id    :integer         not null
#  created_at   :datetime
#  updated_at   :datetime
#

class BalanceUse < ActiveRecord::Base
  belongs_to :player
  validate :ending_at, :presence => true
  validate :player, :presence => true
  validate :balance_type, :presence => true

  before_destroy do
    player.regain_balance(balance_type)
  end
  
  scope :expired, ->{where "ending_at < ?", Time.zone.now}
  def self.destroy_expired
    expired.each(&:destroy)
  end
end

