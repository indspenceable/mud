# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  owner_id   :integer         not null
#  owner_type :string(255)     not null
#  type       :string(255)     not null
#

class Items::Bullet < Item
  
  def hit target
    target.take_damage! 3
  end
  
  def short_name
    'a small grey bullet'
  end
  def long_name
    'A small grey bullet rests here inconspicuously.'
  end
  def called? name
    name=='bullet'
  end
end
