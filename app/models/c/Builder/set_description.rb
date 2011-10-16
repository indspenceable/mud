class C::Builder::SetTitle < Command
  def perform player,arguments
    player.room.desc = arguments
    player.room.save!
  end
end