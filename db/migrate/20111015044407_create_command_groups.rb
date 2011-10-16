class CreateCommandGroups < ActiveRecord::Migration
  def self.up
    create_table :command_groups do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :command_groups
  end
end
