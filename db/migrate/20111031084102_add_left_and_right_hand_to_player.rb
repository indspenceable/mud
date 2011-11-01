class AddLeftAndRightHandToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :left_hand_id, :integer
    add_column :players, :right_hand_id, :integer
  end

  def self.down
    remove_column :players, :right_hand_id
    remove_column :players, :left_hand_id
  end
end
