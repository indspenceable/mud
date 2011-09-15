class AddColorsToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :colors, :text, :default => Player.default_colors.to_yaml
  end

  def self.down
    remove_column :players, :colors
  end
end
