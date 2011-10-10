class <%= detail_name_camelcase %> < ActiveRecord::Base
  belongs_to :<%= class_name_underscore %>
end