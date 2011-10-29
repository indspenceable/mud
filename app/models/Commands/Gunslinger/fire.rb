class Commands::Gunslinger::Fire < Command
  check_standard  
  def perform player,actions
    player.room.echo("#{player.name} fires his gun into the air.")
    player.take_balance! :balance, 1
  end
end