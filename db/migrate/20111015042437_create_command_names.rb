class CreateCommandNames < ActiveRecord::Migration
  def self.up
    create_table :command_names do |t|
      t.references :command, :null => false
      t.references :command_group, :null => false
      t.string :name, :null => false

      t.timestamps
    end
    add_index :command_names, :name, :name => :index_on_names
    add_index :command_names, :command_id, :name => :index_on_commands
    add_index :command_names, [:command_group_id, :name], :name => :index_on_command_groups_names, :unique => true
  end

  def self.down
    drop_table :command_names
  end
end
