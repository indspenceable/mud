namespace :mud do
  desc "Reset database, and load fixtures"
  task :reset => ['db:drop', 'db:migrate', 'db:fixtures:load']
end