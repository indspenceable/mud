class Command < ActiveRecord::Base
  BALANCE_MESSAGES = {
    balance:"You are off balance.",
    equilibrium:'You need to regain equilibrium'
  }
  
  has_many :command_names
  
  def self.check_standard
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
  
  def parse_commands args, *expected_types
    args.split.tap do |arg_list|
      expected_ty
    end
  end
end