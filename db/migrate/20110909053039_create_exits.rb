class CreateExits < ActiveRecord::Migration
  def self.up
    create_table :exits do |t|
      t.string :direction 
      t.references :origin 
      t.references :destination

      t.timestamps
    end
    add_index :exits, :origin_id
  end

  def self.down
    drop_table :exits
  end
end
