# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Drop < Command
  requires_standard_balances
  def perform player, arguments
    player.items.each do |item|
      if item.called? arguments
        player.room.echo "#{player.short_name} drops #{item.short_name}", :ignore => player
        player.output "You drop #{item.short_name}"
        item.update_attributes!(:owner => player.room)
        return
      end
      player.output "You don't have anything with that name."
    end
  end
end
