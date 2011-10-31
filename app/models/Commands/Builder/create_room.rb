# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Builder::CreateRoom < Command
  def perform player,arguments
    Room.create(:name => arguments) rescue return player.output("You must give a title when creating a room")
    player.output("You created a new room.")
  end
end
