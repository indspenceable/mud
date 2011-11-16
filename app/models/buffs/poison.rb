class Buffs::Poison < Debuff
  def name
    'You are afflicted by a most terrible poison.'
  end
  def tick
    # tick damages a player for 1/10 of their hits.
    if rand(200) == 0
      puts "Expiring poison."
      player.output("You are no longer poisoned.")
      update_attributes!(:expired => true)
    else
      puts "Not expiring poison."
    end
  end
end