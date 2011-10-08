class Buff < ActiveRecord::Base
  belongs_to :player
  
  has_many :data_fields
end
