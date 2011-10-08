class CreateBuffs < ActiveRecord::Migration
  def self.up
    create_table :buffs do |t|
      t.references :player
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :buffs
  end
end
