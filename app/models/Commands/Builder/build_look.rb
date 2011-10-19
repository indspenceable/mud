class Commands::Builder::BuildLook < Command
  def self.names
     %w(buildlook bl)
  end
  def perform player,arguments
    player.output("You are in room ##{player.room.id}")
  end
end