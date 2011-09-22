class Extrinsic < ActiveRecord::Base
  serialize :data
  belongs_to :player
end
