module Commands
  class Look
    def initialize
      @names = ['look','l']
    end
    def accept? command
      @names.include? command
    end
    def execute player, arguments
      player.output(player.room.describe(player))
    end
  end
end
Commands::List << Commands::Look.new
