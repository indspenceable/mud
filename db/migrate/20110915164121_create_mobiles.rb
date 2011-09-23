class CreateMobiles < ActiveRecord::Migration
  def self.up
    create_table :mobiles do |t|
      t.string :type, :null => false
      t.references :room, :null => false
      t.text :data, :null => false, :default => {}

      t.timestamps
    end
  end

  def self.down
    drop_table :mobiles
  end
end
