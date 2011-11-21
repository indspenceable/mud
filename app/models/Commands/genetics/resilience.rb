class Commands::Genetics::Resilience < Command
  def perform player, arguments
    b = player.buffed?(::Buffs::Poison)
    return player.output "You aren't poisoned, anyway." unless b
    player.output("You concentrate for a moment, and immediately begin to feel healthier.")
    player.room.echo("#{player.short_name} looks healthier.", :ignore => player)
    b.destroy
    player.use_balance! :balance, 2
  end
end