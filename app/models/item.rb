class Item < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  validate :owner, :presence => true
  
  def self.item_type sym
    define_method(:"#{sym}_type?") do
      true
    end
  end
  
  def method_missing sym, *args
    if sym =~ /.*_type?/
      false
    else
      super
    end
  end

end
