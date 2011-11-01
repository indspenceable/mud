# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Who < Command
  def perform player, arguments
    player.output "Players online:"
    Player.logged_in.each do |p|
      player.output p.short_name
    end
  end
end
