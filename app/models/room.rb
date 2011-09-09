class Room < ActiveRecord::Base
  has_many :players
  has_many :items, :as => :owner
  has_many :exits, :foreign_key => :origin_id
  has_many :arriving_exits, :class_name => "Exit", :foreign_key => :destination_id


  alias :all_players :players

  def players
    all_players.reject{|p| !p.logged_in?}
  end

  def describe ignore_player
    players_here = players.reject{|p| p.id == ignore_player.id}
    players_string = players_here.empty?? nil : (players_here.map{|p| p.name}.to_sentence + ".")
    item_string = nil
    exits_string = nil
    [name,desc,players_string,item_string,exits_string].compact.join("\n")
  end

  #ignore should be the player object
  def echo message, ignore=nil
    players.each do |p|
      p.output message unless p.id == ignore.id
    end
  end
end
