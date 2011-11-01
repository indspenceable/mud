# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Inventory < Command
  def self.names
    %w(inventory inv ii i)
  end
  def perform player, arguments
    if player.items.size > 0
      player.output "You have:"
      player.items.each do |item|
        player.output item.short_name
      end
    else
      player.output "You are carrying nothing."
    end
  end
end
