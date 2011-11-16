require File.expand_path('../../config/environment',  __FILE__)

#MAKE SOME SKILLS
# Only support 1 level of nesting.
default = CommandGroup.find_by_name('default')
Dir.glob("./app/models/commands/*").each do |path|
  #puts "Found #{path}"
  if path =~ /.*\/(.*)\.rb/
    Commands.const_get($1.camelcase).find_or_create_by_type.tap do |cmd|
      Commands.const_get($1.camelcase).names.each do |n|
        cmd.command_names.find_or_create_by_command_group_id_and_name(default.id, n.underscore)
      end
    end
  else
    name_space = path.match(/\/([^\/]*)\z/)[1]
    
    current_group = CommandGroup.find_or_create_by_name(name_space.underscore)
    
    Dir.glob("./app/models/commands/#{$1}/*").each do |sub_path|
      if sub_path =~ /.*\/(.*)\.rb/
          Commands.const_get(name_space.camelcase).const_get($1.camelcase).find_or_create_by_type.tap do |cmd|
             Commands.const_get(name_space.camelcase).const_get($1.camelcase).names.each do |n|
              cmd.command_names.find_or_create_by_command_group_id_and_name(current_group.id, n.underscore)
            end
          end
        #end
      else
        puts "You shouldn't have other nested shit!"
      end
    end
  end
end