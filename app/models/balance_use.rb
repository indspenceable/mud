class BalanceUse < ActiveRecord::Base
  belongs_to :player
  validate :ending_at, :presence => true
  validate :player, :presence => true
  validate :balance_type, :presence => true

  before_destroy do
    player.regain_balance(balance_type)
  end
end
