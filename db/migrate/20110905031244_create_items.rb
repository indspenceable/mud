class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :owner , :null => false
      t.string :owner_type, :null => false
      t.string :instance
    end
  end

  def self.down
    drop_table :items
  end
end
