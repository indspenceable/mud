# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Get < Command
  requires_standard_balances
  def self.names
    %w(g get)
  end
  def perform player, arguments
    room = player.room
    room.items.each do |item|
      if item.called? arguments
        room.echo "#{player.short_name} picks up #{item.short_name}", :ignore => player
        player.output "You pick up #{item.short_name}"
        item.owner = player
        item.save!
        return
      end
    end
    player.output "There is nothing here by that name."
  end
end

