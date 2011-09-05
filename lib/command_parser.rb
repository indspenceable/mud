module Commands
  List = []
  def self.parse player, input 
    input = "say #{input[1,input.length]}" if input[0]=='"' || input[0]=="'"
    input=~(/\A(\w*)\s*(.*)?\z/)
    List.each do |command|
      return command.execute player, $2 if command.accept? $1
    end
    player.output("I don't quite know what you mean by that.")
  end
end
#load all of our commandu
Dir.glob(File.dirname(__FILE__) + '/commands/*') {|file| require file}
