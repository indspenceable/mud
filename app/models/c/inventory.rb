class C::Inventory < Command
  def perform player, arguments
    if player.items.size > 0
      player.output "You have:"
      player.items.each do |i|
        player.output item.short_name
      end
    else
      player.output "You are carrying nothing."
    end
  end
end