class Commands::Builder::BuildLook < Command
  def perform player,arguments
    player.output("You are in room ##{player.room.id}")
  end
end