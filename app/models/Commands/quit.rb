class Commands::Quit < Command
  def perform player,arguments
    player.log_out
  end
end