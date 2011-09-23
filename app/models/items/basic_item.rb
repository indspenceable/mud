class Items::BasicItem < Item
  def short_name
    'item'
  end
  def long_name
    'A basic item.'
  end
  def called? name
    name == 'item'
  end
end
