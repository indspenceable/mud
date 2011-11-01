# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Builder::Goto < Command
  def perform player,arguments
    room = Room.find(arguments.to_i) rescue nil
    if room
      player.room.echo "#{player.short_name} vanishes.", :ignore => player
      player.output("Everything blurs around you and you find yourself in a new place.")
      player.room = room
      player.save!
      player.room.echo "#{player.short_name} materializes.", :ignore => player
    else
      player.output("There's no room with that id.")
    end
  end
end
