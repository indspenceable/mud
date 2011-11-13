# == Schema Information
#
# Table name: revolver_delegates
#
#  id          :integer         not null, primary key
#  bullet_0_id :integer
#  bullet_1_id :integer
#  bullet_2_id :integer
#  bullet_3_id :integer
#  bullet_4_id :integer
#  bullet_5_id :integer
#  revolver_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Items::Delegates::RevolverDelegate < ActiveRecord::Base
  belongs_to :revolver
  6.times do |i|
    belongs_to "bullet_#{i}",  :class_name => "Item",
  end
end
