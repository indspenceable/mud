class Commands::Look < Command
  def self.names
    %w(look l)
  end
  def perform player, args
    player.room.describe_to player
  end
end
