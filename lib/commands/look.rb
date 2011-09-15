module Mud
  module Commands
    class Look
      def initialize
        @names = %w(look l)
      end
      def accept? command
        @names.include? command
      end
      def execute player, arguments
        player.room.describe_to player
      end
    end
  end
end
Mud::Commands::List << Mud::Commands::Look.new
