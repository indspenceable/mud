class C::Builder::Goto < Command
  def perform
    room = Room.find(arguments.to_i) rescue nil
    if room
      player.room.echo "#{player.name} vanishes.", :ignore => player
      player.output("Everything blurs around you and you find yourself in a new place.")
      player.room = room
      player.save!
      player.room.echo "#{player.name} materializes.", :ignore => player
    else
      player.output("There's no room with that id.")
    end
  end
end