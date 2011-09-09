
class Unbound
  def initialize connection
    @connection = connection
    @connection.send_data "Welcome. Please enter a name:\n"
    Log.debug "New connection."
  end
  def process_input unprocessed_data
    data = unprocessed_data.downcase
    Log.debug "Attempting to login as #{data}"
    if Player.exists?(:name => data)
      @connection.send_data("logged in as #{data}.\n")
      @connection.send_data("Shortcuts\n")
      @player = Player.find_by_name(data)
      CONNECTIONS[@player.id] = @connection
      @player.room.echo "#{@player.name} appears magically.", @player
      Log.debug "Logged in!"
      @player.id
    else
      Log.debug("Unable to.")
      @connection.send_data "Unable to log in. Try again.\n"
      nil
    end
  end
end
