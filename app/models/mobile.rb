class Mobile < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :owner
  validate :room, :presence => true

  def take_action
  end

  def hear speaker, words
  end

  def short_name
    raise "short_name undefined for #{self.class}"
  end
  def long_name
    raise "long_name undefined for #{self.class}"
  end
end
