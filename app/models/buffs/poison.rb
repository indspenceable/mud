class Buffs::Poison < Debuff  
  def name
    'You are afflicted by a most terrible poison.'
  end
  
  #once every 200 seconds
  def pulse
    player.output("You feel damaged by the poison")
    player.take_damage! 3
  end
end