class Revolver < Item
  item_type :gun
  
  has_many :bullets

  def short_name
    'revolver'
  end
  def long_name
    'A shiny revolver sits here.'
  end
  def called? name
    ['gun','revolver'].include? name
  end

end