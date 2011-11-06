class Commands::Tell < Command
  def perform player, args
     parse(player, args, [:player], "Usage: TELL <PLAYER> <MESSAGE>") do |target, message|
       player.output("You tell #{target.name}: #{message}")
       target.output("#{player.name} tells you: #{message}")
     end
  end
end