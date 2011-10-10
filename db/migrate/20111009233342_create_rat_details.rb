class CreateRatDetails < ActiveRecord::Migration
  def self.up
    create_table :rat_details do |t|
      t.references :rat
      t.integer :toughness, :null => false, :default => 15
      t.timestamps
    end
  end

  def self.down
    drop_table :rat_details
  end
end
