class C::Say < Command
  def perform player, arguments
    player.room.echo("#{player.name} says: #{arguments}",:ignore => player,:output => {:color => :say});
    player.output("You say: #{arguments}", :color => :say)
    player.room.mobiles.each do |m|
      m.hear player, arguments
    end
  end
end