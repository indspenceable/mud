class Commands::Builder::SetDescription < Command
  def perform player,arguments
    player.room.desc = arguments
    player.room.save!
  end
end