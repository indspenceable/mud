class DataField < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  validate :owner, :presence => true
end
