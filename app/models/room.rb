class Room < ActiveRecord::Base
  has_many :players
  has_many :mobiles
  
  
  has_many :items, :as => :owner
  has_many :exits, :foreign_key => :origin_id
  has_many :arriving_exits, :class_name => "Exit", :foreign_key => :destination_id

  

  alias :all_players :players

  def players
    all_players.reject{|p| !p.logged_in?}
  end

  def describe_to player
    players_here = players - [player]
    player.output name, :color => :title
    player.output desc, :color => :description
    player.output players_here.map{|p| p.name}.to_sentence + ".", :color => :players unless players_here.empty?
    player.output mobiles.map{|m| m.long_name}.join(" "), :color => :mobiles unless mobiles.empty?
    player.output items.map{|i| i.long_name }.join(" "), :color => :items unless items.empty?
    exits_string = case exits.size
                   when 0 then 'You see no exits.'
                   when 1 then "You see an exit to the #{exits[0].direction}."
                   else "You see exits to the #{exits.map{|e| e.direction}.to_sentance}."
                   end
    player.output exits_string, :color => :exits
  end

  #ignore should be the player object, forward the opts[:output]
  def echo message, opts={}
    players.each do |p|
      p.output message,(opts[:output]||{}) unless p == opts[:ignore]
    end
  end
end
