class C::Quit < Command
  def perform player,arguments
    player.log_out
  end
end