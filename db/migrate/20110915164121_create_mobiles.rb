class CreateMobiles < ActiveRecord::Migration
  def self.up
    create_table :mobiles do |t|
      t.string :type, :null => false
      t.references :room, :null => false
      
      t.timestamps
    end
    add_index :mobiles, :type
  end

  def self.down
    drop_table :mobiles
  end
end
