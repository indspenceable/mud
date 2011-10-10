class Create<%= detail_name_camelcase %>s < ActiveRecord::Migration
  def self.up
    create_table :<%= detail_name_underscore %>s do |t|
      t.references :<%= class_name_underscore %>

<% migration_data.each do |str| -%>
<% arg,type = str.split(':') -%>
      t.<%= type %> :<%= arg %>
<% end -%>
      
      t.timestamps
    end
    add_index :<%= detail_name_underscore %>s, :<%= class_name_underscore %>_id, :unique => true
  end

  def self.down
    drop_table :<%= detail_name_underscore %>s
  end
end
