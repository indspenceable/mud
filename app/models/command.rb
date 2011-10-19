class Command < ActiveRecord::Base
  has_many :command_names
  
  def self.names
    [self.name.match(/.*::(.*)\z/)[1]]
  end
end