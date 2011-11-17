class Commands::Genetics::Sting < Command
  requires_standard_balances  
  def perform player, args
    return player.output "You need a scopion tail in order to sting other players." unless player.buffed?(::Buffs::Genetics::ScorpionTail)
    parse(player, args, [:player_here], "Usage: STING <player>") do |target|
      player.room.echo "You sting. rarrh."
    end
  end
end
