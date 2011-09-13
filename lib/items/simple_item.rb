class SimpleItem
  def long_name
    "A simple item is on the ground, but you're not sure what it does."
  end
  def short_name
    "a simple item"
  end
  def called? c
    %(item).include? c
  end
end
