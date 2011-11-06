class CreateRatDelegates < ActiveRecord::Migration
  def self.up
    create_table :rat_delegates do |t|
      t.references :rat
      t.integer :toughness, :null => false, :default => 15
      t.timestamps
    end
    add_index :rat_delegates, :rat_id, :unique => true
  end

  def self.down
    drop_table :rat_delegates
  end
end
