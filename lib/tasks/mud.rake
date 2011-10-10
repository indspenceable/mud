namespace :mud do
  desc "Reset database. Don't load fixtures"
  task :reset => ['db:drop', 'db:migrate', 'db:seed']
end