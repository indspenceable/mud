class CreateExits < ActiveRecord::Migration
  def self.up
    create_table :exits do |t|
      t.string :direction, :null => false
      t.references :origin, :null => false
      t.references :destination, :null => false

      t.timestamps
    end
    add_index :exits, [:origin_id, :direction], :unique => true
  end

  def self.down
    drop_table :exits
  end
end
