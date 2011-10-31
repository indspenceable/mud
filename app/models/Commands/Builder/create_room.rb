class Commands::Builder::CreateRoom < Command
  def perform player,arguments
    Room.create(:name => arguments) rescue return player.output("You must give a title when creating a room")
    player.output("You created a new room.")
  end
end