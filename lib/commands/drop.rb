module Mud
  module Commands
    class Get
      def initialize
        @names = %w(drop)
      end
      def accept? c
        @names.include? c
      end
      def execute player, arguments
        room = player.room
        player.items.each do |item|
          inst = item.instance
          if inst.called? arguments
            room.echo "#{player.name} drops #{inst.short_name}", player
            player.output "You drop #{inst.short_name}"
            item.owner = room
            item.save!
            return
          end
        end
        player.hear "You have nothing here by that name."
      end
    end
  end
end
Mud::Commands::List << Mud::Commands::Get.new
