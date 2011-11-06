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
  has_many :bullets, :class_name => "Items::Bullet", :as => :owner
  item_type :gun
  item_delegate
  
  def loaded?
    0.upto(5) do |i|
      return true if self.send(:"bullet_#{i}")
    end
    false
  end
  
  def next_chamber
    0.upto(5) do |i|
      self.send(:"bullet_#{i}").tap do |b|
        return b if b
      end
    end
    raise "Gun isn't loaded."
  end
  
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
