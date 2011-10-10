class Mobiles::<%= class_name_camelcase %> < Mobile
<%- if migration_data -%>
  owns_one "<%= detail_name_camelcase %>"
  
<%- end -%>
  def take_action
    #TODO
  end
  def hear speaker, words
    #TODO
  end
  def short_name
    #TODO
  end
  def long_name
    #TODO
  end
end