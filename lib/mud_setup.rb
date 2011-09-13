Dir.glob(File.join(File.dirname(__FILE__),"*.rb")).each do |file|
  #require File.basename(file,'.rb')
  require file
end
