class C::Builder::SetTitle < Command
  def perform player,arguments
    player.room.name = arguments
    player.room.save!
  end
end