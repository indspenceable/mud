#reset using the rake task
`bundle exec rake mud:reset`

#load the rails environment
require File.expand_path('../../config/environment',  __FILE__)

Dir.glob("./script/seed_*.rb").each do |f|
  require f
end