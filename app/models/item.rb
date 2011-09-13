class Item < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  serialize :instance
end
