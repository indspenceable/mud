# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Builder::CreateExit < Command
  def perform player,arguments
    dir,target = arguments.split
    player.output "Please use a valid direction" or return unless Player::Exits.valid_standard_exit? dir
    r = Room.find(target) rescue nil
    player.output "There's no room with that id" or return unless r
    Exit.create(:direction => dir, :origin => player.room, :destination => r)
    player.output ("You created an exit to the #{dir}")
  end
end
