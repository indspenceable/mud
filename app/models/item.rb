# == Schema Information
#
# Table name: items
#
#  id         :integer         not null, primary key
#  owner_id   :integer         not null
#  owner_type :string(255)     not null
#  type       :string(255)     not null
#

class Item < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  validate :owner, :presence => true
  
  def self.item_type sym
    define_method(:"#{sym}_type?") {true}
  end
  
  def method_missing sym, *args
    sym =~ /.*_type?/ ? false : super
  end
end

