# == Schema Information
#
# Table name: commands
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Command < ActiveRecord::Base
  
  BALANCE_MESSAGES = {
    balance:"You are off balance.",
    equilibrium:'You need to regain equilibrium'
  }
  
  has_many :command_names
  
  def self.requires_standard_balances
    check :balance, :equilibrium
  end
  # balance requirements
  def self.check *args
    @balances ||=[] 
    @balances += args
  end
  def self.balances
    @balances ||= []
  end
  
  def perform_with_balance_check player, arguments
    self.class.balances.each do |balance,message| 
      return player.output(BALANCE_MESSAGES[balance] || "You need to regain #{balance}" ) unless player.has_balance? balance
    end
    perform player, arguments
  end
  
  def self.names
    [self.name.match(/.*::(.*)\z/)[1]]
  end
  
  
  def parse player, args, expected_types, usage_error_message = nil
    return (usage_error_message ? player.output(usage_error_message) : nil) unless args && args.split(' ').length >= expected_types.length
    list = []
    expected_types.each do |t|
      current,args = args.split(' ',2)
      list << case t
                when :player_here
                  player.room.players.find_by_name(current).tap do |x|
                    player.output "There is no one here by that name." or return unless x
                  end
                when :player
                  Player.find_by_name(current).tap do |x|
                    player.output "There is no player by that name." or return unless x
                  end
                when :item_inventory
                  player.items.detect{ |x| x.called? current } or return
                else
                  raise "Command (#{self.name}) tried to parse type #{t} but there's not a valid parsing for that."
                end
    end
    list << args if args
    yield *list
  end
end
