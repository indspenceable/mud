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
  belongs_to :owner, :polymorphic => true , :validate => true
  #validate :owner, :presence => true
  
  def self.item_type sym
    define_method(:"#{sym}_type?") {true}
  end
  
  def respond_to? sym, include_private=false
    super || sym =~ /_type?\z/
  end
  def method_missing sym, *args
    sym =~ /_type?\z/ ? false : super
  end
     
  def self.item_delegate
    delegate_type = name.match(/Items::(.*)/)[1].underscore
    owns_one delegate_type, "Items::Delegates::#{delegate_type.camelcase}Detail"
  end
end

