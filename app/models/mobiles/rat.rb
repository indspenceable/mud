class Mobiles::Rat < Mobile
  after_save :init_data

  def take_action
    if self.data[:action_timeout] <= 0
      room.echo "#{short_name} growls menacingly".capitalize
      self.data[:action_timeout] = rand(5) + 10
    else
      self.data[:action_timeout] -= 1
    end
    save!
  end

  def short_name
    "a filty rat"
  end
  def long_name
    "a filthy rat is scurries about here."
  end

  private
  def init_data
    10.times {puts "HELLO WORLD."}
    self.data = {:action_timeout => 10}
  end
end
