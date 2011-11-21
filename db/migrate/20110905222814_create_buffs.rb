class CreateBuffs < ActiveRecord::Migration
  def self.up
    create_table :buffs do |t|
      t.references :player, :null => false
      t.boolean :debuff, :null => false
      t.boolean :expired, :null => false, :default => false
      t.boolean :needs_pulse, :null => false, :default => false
      t.string :type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :buffs
  end
end
