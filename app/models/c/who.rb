class C::Who < Command
  def perform player, arguments
    player.output "Players online:"
    Player.logged_in.each do |p|
      player.output p.name
    end
  end
end