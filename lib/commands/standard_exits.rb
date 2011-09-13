module Mud
  module Commands
    class StandardExit
      def initialize name
        @direction = name
        @names = [name, name[0]]
      end
      def accept? command
        @names.include? command
      end
      def execute player, arguments
        my_exit = player.room.exits.find_by_direction(@direction) rescue nil
        if my_exit
          player.room.echo("#{player.name} leaves to the #{my_exit.direction}.", player)
          player.output("You leave to the #{my_exit.direction}.")
          player.room = my_exit.destination
          player.save!
          player.room.echo("#{player.name} arrives from the #{Exit.reverse(my_exit.direction)}.", player)
          player.process_input("look")
        else
          player.output("You can't go in that direction.")
        end
      end
    end
  end
end

%w(north south east west).each do |c|
  Mud::Commands::List << Mud::Commands::StandardExit.new(c)
end
