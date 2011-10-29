class Commands::Quit < Command
  def self.names
    %w(quit qq)
  end
  def perform player,arguments
    player.log_out!
  end
end