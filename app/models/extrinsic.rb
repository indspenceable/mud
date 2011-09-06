require 'effects/output'
require 'effects/take_damage'
class Extrinsic < ActiveRecord::Base
  serialize :klass
  belongs_to :player
end
