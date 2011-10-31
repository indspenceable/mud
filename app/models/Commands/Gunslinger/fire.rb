class Commands::Gunslinger::Fire < Command
  check_standard  
  def perform player, args
    target, = parse(player, args, [:player_here], "Usage: FIRE <player>")
    if target
      return player.output("You can't shoot yourself.") if player==target
      player.room.echo("#{player.name} fires his gun at #{target.name}", :ignore => [player,target])
      player.output("You fire your gun at #{target.name}")
      target.output("#{player.name} fires his gun at you.")
      target.take_damage! 3
      player.use_balance! :balance, 2
    end
  end
end