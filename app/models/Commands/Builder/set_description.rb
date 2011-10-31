# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Builder::SetDescription < Command
  def perform player,arguments
    player.room.desc = arguments
    player.room.save!
  end
end
