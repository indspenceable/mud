module Commands
  class Quit
    def initialize
      @names = ['quit']
    end
    def accept? command
      @names.include? command
    end
    def execute player, arguments
      player.room.echo "#{player.name} disapears.", player
      player.logout
    end
  end
end
Commands::List << Commands::Quit.new
