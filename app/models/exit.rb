# == Schema Information
#
# Table name: exits
#
#  id             :integer         not null, primary key
#  direction      :string(255)     not null
#  origin_id      :integer         not null
#  destination_id :integer         not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Exit < ActiveRecord::Base
  belongs_to :origin, :class_name => "Room", :foreign_key => "origin_id"
  belongs_to :destination, :class_name => "Room", :foreign_key => "destination_id"
  validate :direction, :presence => true
  validate :origin, :presence => true
  validate :destination, :presence => true


  @@reverse_exits = {
    'north' => 'south',
    'south' => 'north',
    'east' => 'west',
    'west' => 'east'}

  def self.reverse direction
    @@reverse_exits[direction] || 'ether'
  end
  def reverse
    self.class.reverse direction
  end
end


