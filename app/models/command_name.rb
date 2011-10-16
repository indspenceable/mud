class CommandName < ActiveRecord::Base
  belongs_to :command_group
  belongs_to :command
end
