class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name, :null => false

      #passwords
      t.string :password_hash
      t.string :password_salt

      #output
      t.string :pending_output
      t.boolean :logging_out

      t.references :room

      #settings
      t.text :colors
    end
    add_index :players, :name
  end

  def self.down
    drop_table :players
  end
end
