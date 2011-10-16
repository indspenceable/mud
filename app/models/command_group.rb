class CommandGroup < ActiveRecord::Base
  has_many :command_names
  #has_many :skill_sets
  has_and_belongs_to_many :players
  has_many :commands, :through => :command_names
end
