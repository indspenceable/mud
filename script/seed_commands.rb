#MAKE SOME SKILLS
default = CommandGroup.find_by_name('default')
builder = CommandGroup.find_or_create_by_name('builder')

puts "def is #{default.inspect} builder = #{builder.inspect}"
['Drop', 'Exit', 'Get', %w(Inventory Inv Ii I), %w(Look l), %w(Quit qq), "Say", "Who"].each do |name|
  names = [name].flatten
  Commands.const_get(names.first).find_or_create_by_type.tap do |cmd|
    names.each do |n|
      puts "Name is #{n}"
      cmd.command_names.find_or_create_by_command_group_id_and_name(default, n.underscore)
    end
  end
end
[%w(BuildLook bl), %w(CreateExit dig), %w(CreateRoom), %(Goto), %w(RemoveExit), %w(Rooms), %w(SetDescription), %w(SetTitle)].each do |name|
  names = [name].flatten
  Commands::Builder.const_get(names.first).find_or_create_by_type.tap do |cmd|
    names.each do |n|
      puts "Name is #{n}"
      puts cmd.command_names.find_or_create_by_command_group_id_and_name(builder.id, n.underscore).command_group.name
    end
  end
end
=begin
Commands::Drop.create.command_names.create(:command_group => default, :name => 'drop')
Commands::Exit.create.command_names.create(:command_group => default, :name => 'exit')
Commands::Get.create.command_names.create(:command_group => default, :name => 'get')
Commands::Inventory.create.command_names.create(:command_group => default, :name => 'i')
Commands::Look.create.command_names.create(:command_group => default, :name => 'look')
Commands::Quit.create.command_names.create(:command_group => default, :name => 'quit')
Commands::Say.create.command_names.create(:command_group => default, :name => 'say')
Commands::Who.create.command_names.create(:command_group => default, :name => 'who')
=end