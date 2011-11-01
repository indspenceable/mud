class Commands::Wield < Command
  requires_standard_balances
  def perform player, args
    parse(player, args, [:item_inventory], "Usage: WIELD <item>") do |item|
      # if a player is weidling something, they can't wield
      if player.right_hand
        player.output "You can't wield something when you've already got something in your hand."
      else
        #Wield the item.
        player.room.echo("#{player.short_name} wields #{item.short_name}.", :ignore => player)
        player.output("You wield #{item.short_name}.")
        player.update_attributes!(:right_hand => item)
      end
    end
  end
end
