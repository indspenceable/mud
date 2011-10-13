CONNECTIONS = {}
Log = Logger.new(STDOUT)

require 'player_connection'

class ActiveRecord::Base
  #facilitate using class details
   def self.owns_one(class_name)
     assoc = "owned_#{class_name.underscore}"
     has_one assoc, :class_name => class_name, :autosave => true
     reflect_on_association(assoc).klass.column_names.reject do |column_name|
       column_name=~(/(\A|_)id\z/) || %w(created_at updated_at).include?(column_name)
     end.each do |column_name|
         [:"#{column_name}?", :"#{column_name}_before_type_cast", :"#{column_name}=", :"_#{column_name}", 
         column_name, :"#{column_name}_changed?", :"#{column_name}_change", :"#{column_name}_will_change!", 
         :"#{column_name}_was", :"reset_#{column_name}"].each do |method_name|
         define_method(method_name) do |*args|
           self.send(assoc).send(method_name, *args)
         end
       end
     end
     after_create do
       self.send(:"create_#{assoc}")
       save!
     end
   end
end