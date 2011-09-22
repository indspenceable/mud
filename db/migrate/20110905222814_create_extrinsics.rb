class CreateExtrinsics < ActiveRecord::Migration
  def self.up
    create_table :extrinsics do |t|
      t.references :player
      t.string :type
      t.text :data

      t.timestamps
    end
  end

  def self.down
    drop_table :extrinsics
  end
end
