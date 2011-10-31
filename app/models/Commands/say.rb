# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Say < Command
  def perform player, arguments
    player.room.echo("#{player.name} says: #{arguments}",:ignore => player,:output => {:color => :say});
    player.output("You say: #{arguments}", :color => :say)
    player.room.mobiles.each do |m|
      m.hear player, arguments
    end
  end
end
