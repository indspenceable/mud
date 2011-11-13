Log = Logger.new(STDOUT)

require 'player_connection'

class ActiveRecord::Base
    #facilitate using class delegates
  def self.owns_one delegate_type, class_name
    association_name = :"#{delegate_type}_delegate"
    has_one association_name, :class_name => class_name, :autosave => true, :dependent => :destroy
    reflect_on_association(association_name).klass.tap do |k|
      # For each column on that model, forward associated instance methods to it.
      (k.column_names - %w(id created_at updated_at)).each do |column_name|
        [:"#{column_name}?", :"#{column_name}_before_type_cast", :"#{column_name}=", :"_#{column_name}", 
        column_name, :"#{column_name}_changed?", :"#{column_name}_change", :"#{column_name}_will_change!", 
        :"#{column_name}_was", :"reset_#{column_name}"].each do |method_name|
          define_method(method_name) do |*args|
            self.send(association_name).send(method_name, *args)
          end
        end
      end
      #Other than the back association, forward all assocation methods to the delegate
      k.reflect_on_all_associations.reject{|a| a.macro==:belongs_to && a.name==delegate_type }.each do |a|
        syms = [:"#{a.name}",:"#{a.name}="].each do |name|
          define_method(name) do |*args|
            self.send(association_name).send(name, *args)
          end
        end
      end
    end
    after_create do 
      self.send :"create_#{association_name}"
    end
  end
end