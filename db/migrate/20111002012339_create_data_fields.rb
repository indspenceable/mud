class CreateDataFields < ActiveRecord::Migration
  def self.up
    create_table :data_fields do |t|
      t.string :key
      t.string :value
      t.references :owner
      t.string :owner_type

      t.timestamps
    end
    #add_index :data_fields [:owner_type, :owner, :key], :unique => true
  end

  def self.down
    drop_table :data_fields
  end
end
