class CreateBalanceUses < ActiveRecord::Migration
  def self.up
    create_table :balance_uses do |t|
      t.string :balance_type, :null => false
      t.datetime :ending_at, :null => false
      t.references :player, :null => false

      t.timestamps
    end
    add_index :balance_uses, [:player_id, :balance_type], :unique => true, :name => 'index_on_player_id_balance_types'
  end

  def self.down
    drop_table :balance_uses
  end
end
