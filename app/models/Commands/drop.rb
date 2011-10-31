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
  check_standard
  def perform player, arguments
    room = player.room
    player.items.each do |item|
      if item.called? arguments
        room.echo "#{player.name} drops #{item.short_name}", :ignore => player
        player.output "You drop #{item.short_name}"
        item.owner = room
        item.save!
        return
      end
    end
  end
end
