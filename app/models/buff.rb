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
  scope :buffs, where(:debuff => false)
  scope :debuffs, where(:debuff => true)
  scope :need_pulse, where(:needs_pulse => true)
  
  before_create do
    self.debuff = self.debuff?
    self.needs_pulse = self.respond_to?(:pulse)
    true
  end
  def debuff?
    false
  end
  def merge!
  end
  def expire!
    update_attributes!(:expired => true)
  end
  def self.destroy_expired
    where(:expired => true).each(&:destroy)
  end
  def self.buff_delegate
    delegate_type = name.match(/Buffs::(.*)/)[1].underscore
    owns_one delegate_type, "Buffs::Delegates::#{delegate_type.camelcase}Delegate"
  end
end
