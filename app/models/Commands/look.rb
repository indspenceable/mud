# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Look < Command
  def self.names
    %w(look l)
  end
  def perform player, args
    player.room.describe_to player
  end
end

