class Commands::Drop < Command
  def perform player, arguments
    room = player.room
    player.items.each do |item|
      if item.called? arguments
        room.echo "#{player.name} drops #{item.short_name}", :ignore => player
        player.output "You drop #{item.short_name}"
        item.owner = room
        item.save!
        return
      end
    end
  end
end