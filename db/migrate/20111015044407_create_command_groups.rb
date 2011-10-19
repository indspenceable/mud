class CreateCommandGroups < ActiveRecord::Migration
  def self.up
    create_table :command_groups do |t|
      t.string :name, :null => false
      t.string :prefix

      t.timestamps
    end
    add_index :command_groups, :prefix, :unique => true
  end

  def self.down
    drop_table :command_groups
  end
end
