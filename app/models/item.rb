class Item < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  serialize :data
end
