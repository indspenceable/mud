class C::Builder::Rooms < Command
  def perform player,arguments
    player.output("Rooms:\n" + Room.all.map{|r| "#{r.id}: #{r.name}"}.join("\n"))
  end
end