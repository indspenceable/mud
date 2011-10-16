class C::Look < Command
  def perform player, args
    player.room.describe_to player
  end
end
