class Mobile < ActiveRecord::Base
  belongs_to :room
  has_many :items, :as => :owner
  serialize :data
end
