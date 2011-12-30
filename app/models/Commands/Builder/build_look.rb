# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

module Commands
  module Builder
    class BuildLook < Command
      def self.names
         %w(buildlook bl)
      end
      def perform player,arguments
        player.output("You are in room ##{player.room.id}")
      end
    end
  end
end