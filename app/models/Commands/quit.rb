# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Quit < Command
  def self.names
    %w(quit qq)
  end
  def perform player,arguments
    player.log_out!
  end
end
