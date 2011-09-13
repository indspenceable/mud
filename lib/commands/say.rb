module Mud
  module Commands
    class Say
      def initialize
        @names = %w(say)
      end
      def accept? command
        @names.include? command
      end
      def execute player, arguments
        player.room.echo("#{player.name} says: #{arguments}",player);
        player.output("You say: #{arguments}")
      end
    end
  end
end
Mud::Commands::List << Mud::Commands::Say.new
