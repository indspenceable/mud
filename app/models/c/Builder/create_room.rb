class C::Builder::CreateRoom < Command
  def perform player,arguments
    Room.create(:name => arguments)
    player.output("You created a new room.")
  end
end