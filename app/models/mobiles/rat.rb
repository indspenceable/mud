# == Schema Information
#
# Table name: mobiles
#
#  id         :integer         not null, primary key
#  type       :string(255)     not null
#  room_id    :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

class Mobiles::Rat < Mobile
  owns_one "RatDetail"
  
  def take_action
  end

  def short_name
    "a filty rat"
  end
  def long_name
    "a filthy rat is scurries about here."
  end
end

