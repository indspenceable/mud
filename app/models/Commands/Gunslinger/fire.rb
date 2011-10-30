class Commands::Gunslinger::Fire < Command
  check_standard  
  def perform player,actions  
    #targets, error = Command.parse(actions, :player)
    
    player.room.echo("#{player.name} fires his gun into the air.")
    player.use_balance! :balance, 1
  end
end