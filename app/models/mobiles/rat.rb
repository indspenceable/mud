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
