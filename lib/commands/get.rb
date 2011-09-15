module Mud
  module Commands
    class Get
      def initialize
        @names = %w(get g)
      end
      def accept? c
        @names.include? c
      end
      def execute player, arguments
        room = player.room
        room.items.each do |item|
          inst = item.instance
          if inst.called? arguments
            room.echo "#{player.name} picks up #{inst.short_name}", :ignore => player
            player.output "You pick up #{inst.short_name}"
            item.owner = player
            item.save!
            return
          end
        end
        player.hear "There is nothing here by that name."
      end
    end
  end
end
Mud::Commands::List << Mud::Commands::Get.new
