class Commands::Gunslinger::Wait < Command
  def perform player,arguments
    player.take_balance(:balance, 1)
  end
end