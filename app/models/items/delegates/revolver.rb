class Items::Delegates::Revolver < ActiveRecord::Base
  belongs_to :revolver
  6.times do |i|
    belongs_to "bullet_#{i}",  :class_name => "Item",
  end
end