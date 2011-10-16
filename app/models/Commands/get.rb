class Commands::Get < Command
  def perform player, arguments
    room = player.room
    room.items.each do |item|
      if item.called? arguments
        room.echo "#{player.name} picks up #{item.short_name}", :ignore => player
        player.output "You pick up #{item.short_name}"
        item.owner = player
        item.save!
        return
      end
    end
    player.output "There is nothing here by that name."
  end
end
