class MobileGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :migration_data, :type => :array, :optional => true

  def create_mobile_model
    if migration_data
      template "migration.rb", "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_#{detail_name_underscore}s.rb"
      template "details.rb", "app/detail_models/#{detail_name_underscore}.rb"
    end
    template "model.rb", "app/models/mobiles/#{class_name_underscore}.rb"
  end
  
  private
  
  def detail_name_underscore
    "#{@name.underscore}_detail"
  end
  def detail_name_camelcase
    detail_name_underscore.camelcase
  end
  def class_name_camelcase
    class_name_underscore.camelcase
  end
  def class_name_underscore
    @name.underscore
  end
end
