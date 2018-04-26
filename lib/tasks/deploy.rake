task :deploy do

  RAILS_ENV = ENV['RAILS_ENV'] || 'production'

  puts "\n------> Updating Gem Bundle \n"
  sh "bundle check || bundle install --deployment --without development:test"
  puts "------> Done bundling"

  puts "\n------> Running Migrations..."
  sh "bundle exec rake db:migrate RAILS_ENV=#{RAILS_ENV}"
  puts "------> Done migrating"

  puts "\n------> Precompiling Assets..."
  sh "bundle exec rake assets:precompile RAILS_ENV=#{RAILS_ENV}"
  puts "------> Done compiling\n"

  puts "\n------> Restarting..."
  sh "touch tmp/restart.txt"

  puts "\n------> Restarting Sidekiq..."
  sh "sudo systemctl restart sidekiq-feira5"

  puts "\n\n"

end
