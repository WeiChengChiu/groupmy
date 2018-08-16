namespace :dev do
  desc 'db: drop, create, migrate, seed'
  task fake: ['db:drop', 'db:create', 'db:migrate', 'db:seed']
end
