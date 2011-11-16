# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Gunslinger::Fire < Command
  requires_standard_balances  
  def perform player, args
    parse(player, args, [:player_here], "Usage: FIRE <player>") do |target|
      #error checking
      return player.output("You can't shoot yourself.") if player==target
      #are they wielding a gun?
      return player.output("You need wield a gun in order to fire it.") unless player.right_hand && player.right_hand.gun_type?
      
      gun = player.right_hand
      
      if gun.loaded?
        player.room.echo("#{player.short_name} fires #{gun.short_name} at #{target.name}", :ignore => [player,target])
        player.output("You fire #{gun.short_name} at #{target.name}")
        target.output("#{player.short_name} fires #{gun.short_name} at you.")
        #bullet = #gun.next_chamber.hit(target)
        target.take_damage!(3)
        target.afflict(::Buffs::Poison)
        player.use_balance! :balance, 2
      else
        player.room.echo("#{player.short_name} fires #{gun.short_name}, but it is out of bullets.", :ignore => player)
        player.output("You fires #{gun.short_name}, but it is out of bullets.")
        player.use_balance(:balance, 1)
      end
      
    end
  end
end
