# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Exit < Command
  requires_standard_balances
  
  def perform player, exit_direction
    my_exit = player.room.exits.find_by_direction(exit_direction) rescue nil
    if my_exit
      player.room.echo("#{player.short_name} leaves to the #{my_exit.direction}.", :ignore => player)
      player.output("You leave to the #{my_exit.direction}.")
      player.room = my_exit.destination
      player.save!
      player.room.echo("#{player.short_name} arrives from the #{my_exit.reverse}.", :ignore => player)
      player.process_input("look")
    else
      player.output("You can't go in that direction.")
    end
  end
end
