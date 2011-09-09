class Exit < ActiveRecord::Base
  belongs_to :origin, :class_name => "Room", :foreign_key => "origin_id"
  belongs_to :destination, :class_name => "Room", :foreign_key => "destination_id"

  @@reverse_exits = {
    'north' => 'south',
    'south' => 'north',
    'east' => 'west',
    'west' => 'east'}

  def self.reverse direction
    @@reverse_exits[direction] || 'ether'
  end
end
