module Mud
  module Commands
    class StandardExit
      def initialize name,short_name
        @direction = name
        @names = [name,short_name]
      end
      def accept? command
        @names.include? command
      end
      def execute player, arguments
        my_exit = player.room.exits.find_by_direction(@direction) rescue nil
        if my_exit
          player.room.echo("#{player.name} leaves to the #{my_exit.direction}.", :ignore => player)
          player.output("You leave to the #{my_exit.direction}.")
          player.room = my_exit.destination
          player.save!
          player.room.echo("#{player.name} arrives from the #{Exit.reverse(my_exit.direction)}.", :ignore => player)
          player.process_input("look")
        else
          player.output("You can't go in that direction.")
        end
      end
    end
  end
end

%w(north south east west).each do |c|
  Mud::Commands::List << Mud::Commands::StandardExit.new(c, c[0])
end
[%w(northeast ne),%w(northwest nw),%w(southeast se),%w(southwest sw)].each do |c|
  Mud::Commands::List << Mud::Commands::StandardExit.new(*c)
end
