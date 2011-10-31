# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Builder::RemoveExit < Command
  def perform player,arguments
    begin
      player.room.exits.where(:direction => arguments).first.destroy
      player.output "You destroyed that exit"
    rescue
      player.output "There is no exit in that direction."
    end
  end
end
