class Mobiles::SimpleMob < Mobile
  def take_action
    if data[:to_say]
      room.echo *(data[:to_say].pop) until data[:to_say].empty?
    end
    save
  end

  def hear speaker, words
    if speaker.is_a?(Player) && words =~ /danny/
      room.echo "Ha!"
      data[:to_say] ||= []
      data[:to_say] << ["mobile says: isn't danny just grand?", :output => {:color => :say}]
      save
    end
  end

  def short_name
    "mob"
  end
  def long_name
    "A simple mob stands here, wallowing in it's own pity."
  end
end
