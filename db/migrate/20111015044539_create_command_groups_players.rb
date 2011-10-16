class CreateCommandGroupsPlayers < ActiveRecord::Migration
  def self.up
    create_table :command_groups_players, :id => false do |t|
      t.references :player
      t.references :command_group
    end
  end

  def self.down
    drop_table :command_groups_players
  end
end
