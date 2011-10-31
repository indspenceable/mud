# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Commands::Builder::Rooms < Command
  def perform player,arguments
    player.output("Rooms:\n" + Room.all.map{|r| "#{r.id}: #{r.name}"}.join("\n"))
  end
end
