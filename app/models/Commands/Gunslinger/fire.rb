class Commands::Gunslinger::Fire < Command
  def perform player,actions
    player.room.echo("#{player.name} fires his gun into the air.")
  end
end