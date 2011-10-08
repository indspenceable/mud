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

      t.references :room, :null => false

      #settings
      t.text :colors#, :null => false, :default => {:title => :red, :say => :cyan}.to_yaml
    end
    add_index :players, :name
  end

  def self.down
    drop_table :players
  end
end
