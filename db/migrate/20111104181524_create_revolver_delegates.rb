class CreateRevolverDelegates < ActiveRecord::Migration
  def self.up
    create_table :revolver_delegates do |t|
      6.times do |i|
        t.references "bullet_#{i}"
      end
      t.references :revolver
      t.timestamps
    end
    add_index :revolver_delegates, :revolver_id, :name => :index_on_revolver_id, :unique => true
  end

  def self.down
    drop_table :revolver_delegates
  end
end
