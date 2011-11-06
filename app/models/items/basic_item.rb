# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  owner_id   :integer         not null
#  owner_type :string(255)     not null
#  type       :string(255)     not null
#

class Items::BasicItem < Item
  item_type :basic
  
  def short_name
    'a basic item'
  end
  def long_name
    'A basic item lies here.'
  end
  def called? name
    name == 'item'
  end
end

