Dir.glob(File.join(File.dirname(__FILE__),'effects','*.rb')).each do |item|
  puts "Loading effect #{item}"
  require item
end
