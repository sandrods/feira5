source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
gem 'sprockets', '~> 3.7.2'

gem 'webpacker'

gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable (or Sidekiq) in production
gem 'redis', '~> 4.0'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'fabrication'
  gem 'faker'
end

# group :test do
#   gem 'rspec-rails', '~> 3.7'
#   gem "capybara"
#   gem 'selenium-webdriver'
#   gem 'chromedriver-helper'
#   gem "launchy"
#   gem 'spring-commands-rspec'
#
#   gem 'shoulda'
#   gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers', branch: 'rails-5'
#   gem "webmock"
#   gem 'timecop'
#
#   gem 'capybara-select2', github: 'goodwill/capybara-select2'
# end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'table_print'
  gem 'rails-erd'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'font-awesome-sass', '~> 5.0.9'

gem 'simple_form'
gem "select2-rails"
gem 'pickadate-rails'
gem 'ransack'
gem "kaminari"

gem 'delocalize'

gem 'pry-rails'

gem 'hashr'

# gem "mongo_uploader", github: "tre-rs/mongo-uploader"

# gem 'sidekiq'
# gem 'redis-namespace'

gem 'prawn'
gem 'barby'

gem 'odf-report'

gem "chartkick"
gem "highcharts-rails"
gem 'groupdate'
