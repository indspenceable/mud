# == Schema Information
#
# Table name: command_names
#
#  id               :integer         not null, primary key
#  command_id       :integer         not null
#  command_group_id :integer         not null
#  name             :string(255)     not null
#  created_at       :datetime
#  updated_at       :datetime
#

class CommandName < ActiveRecord::Base
  validate :command, :presence => true
  validate :command_group, :presence => true
  validate :name, :presence => true
  belongs_to :command_group
  belongs_to :command
end

