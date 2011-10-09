class Dispatch
  def self.parse player, input 
    input = "say #{input[1,input.length]}" if input[0]=='"' || input[0]=="'"
    input=~(/\A(\w*)\s*(.*)?\z/)

    if @@command_names.key? $1
      return send @@command_names[$1], player, $2 
    else
      player.output("I don't quite know what you mean by that.")
    end
  rescue Object => e
    puts "Triggered Exception"
    puts e
    puts "***********"
    puts e.backtrace
    player.output("You've triggered an uncaught exception. That's too bad. Please don't do that again, for the immediate time being? Thanks!")
  end

  @@command_names = {}
  def self.command names, command_method = nil, &blk
    command_method ||= names[0].to_sym
    @@command_names.merge! Hash[names.map{|n| [n,command_method]}]
    define_singleton_method command_method, &blk
  end

  command %w(look l) do |player,args|
    player.room.describe_to player
  end

  command %w(drop) do |player,arguments|
    room = player.room
    player.items.each do |item|
      if item.called? arguments
        room.echo "#{player.name} drops #{item.short_name}", :ignore => player
        player.output "You drop #{item.short_name}"
        item.owner = room
        item.save!
        return
      end
    end

  end
  command %w(get g) do |player,arguments|
    room = player.room
    room.items.each do |item|
      if item.called? arguments
        room.echo "#{player.name} picks up #{item.short_name}", :ignore => player
        player.output "You pick up #{item.short_name}"
        item.owner = player
        item.save!
        return
      end
    end
    player.output "There is nothing here by that name."
  end

  command %w(inventory i ii inv) do |player, arguments|
    if player.items.size > 0
      player.output "You have:"
      player.items.each do |i|
        player.output item.short_name
      end
    else
      player.output "You are carrying nothing."
    end
  end

  command %w(quit qq) do |player,arguments|
    player.log_out
  end

  command %w(say) do |player, arguments|
    player.room.echo("#{player.name} says: #{arguments}",:ignore => player,:output => {:color => :say});
    player.output("You say: #{arguments}", :color => :say)
    player.room.mobiles.each do |m|
      m.hear player, arguments
    end
  end

  [%w(north n), %w(south s), %w(east e), %w(west w)].each do |names|
    command names do |player, arguments|
      my_exit = player.room.exits.find_by_direction(names[0]) rescue nil
      if my_exit
        player.room.echo("#{player.name} leaves to the #{my_exit.direction}.", :ignore => player)
        player.output("You leave to the #{my_exit.direction}.")
        player.room = my_exit.destination
        player.save!
        player.room.echo("#{player.name} arrives from the #{Exit.reverse(my_exit.direction)}.", :ignore => player)
        player.process_input("look")
      else
        player.output("You can't go in that direction.")
      end
    end
  end

  command %w(who) do |player,arguments|
    player.output "Players online:"
    Player.logged_in.each do |p|
      player.output p.name
    end
  end

  command %w(goto) do |player,arguments|
    begin
      room = Room.find(arguments.to_i)
      player.room.echo "#{player.name} vanishes.", :ignore => player
      player.output("Everything blurs around you and you find yourself in a new place.")
      player.room = room
      player.save!
      player.room.echo "#{player.name} materializes.", :ignore => player
    rescue
      player.output("There's no room with that id.")
    end
  end
  
  command %w(rooms) do |player, arguments|
    player.output("Rooms:\n" + Room.all.map{|r| "#{r.id}: #{r.name}"}.join("\n"))
  end
  
  command %w(bl buildlook buildl blook) do |player, arguments|
    player.output("You are in room ##{player.room.id}")
  end
  
  command %w(set_title) do |player,arguments|
    player.room.name = arguments
    player.room.save!
  end
  
  command %w(set_desc) do |player,arguments|
    player.room.desc = arguments
    player.room.save!
  end
  
  command %w(create_room) do |player, arguments|
    Room.create(:name => arguments)
    player.output("You created a new room.")
  end
  
  command %w(create_exit) do |player, arguments|
    dir,target = arguments.split
    player.output "Please use a valid direction" or break unless %w(north south east west).include? dir
    r = Room.find(target) rescue nil
    player.output "There's no room with that id" or break unless r
    Exit.create(:direction => dir, :origin => player.room, :destination => r)
    player.output ("You created an exit to the #{dir}")
  end
  
  command %w(remove_exit) do |player, arguments|
    begin
      player.room.exits.where(:direction => arguments).first.destroy
      player.output "You destroyed that exit"
    rescue
      player.output "There is no exit in that direction."
    end
  end
end
