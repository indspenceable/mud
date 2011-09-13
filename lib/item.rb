puts "Hey broski."
Dir.glob(File.join(File.dirname(__FILE__),'items','*.rb')).each do |item|
  puts "Loading item #{item}"
  require item
end
