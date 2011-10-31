# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Builder::SetTitle < Command
  def perform player,arguments
    player.room.name = arguments
    player.room.save!
  end
end
