# == Schema Information
#
# Table name: command_groups
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  prefix     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CommandGroup < ActiveRecord::Base
  has_many :command_names
  has_and_belongs_to_many :players
  has_many :commands, :through => :command_names
  validate :name, :presence => true, :uniqueness => true
  scope :without_prefix, where('PREFIX IS NULL')
end

