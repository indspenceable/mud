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
        player.room.echo("#{player.name} says: #{arguments}",:ignore => player,:output => {:color => :say});
        player.output("You say: #{arguments}", :color => :say)
      end
    end
  end
end
Mud::Commands::List << Mud::Commands::Say.new
