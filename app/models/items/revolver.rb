# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  owner_id   :integer         not null
#  owner_type :string(255)     not null
#  type       :string(255)     not null
#

class Items::Revolver < Item
  item_type :gun
  
  has_many :bullets

  def short_name
    'a shiny revolver'
  end
  def long_name
    'A shiny revolver sits here.'
  end
  def called? name
    ['gun','revolver'].include? name
  end

end
