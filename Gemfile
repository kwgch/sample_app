source 'https://rubygems.org'
# ruby "1.9.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'bootstrap-sass'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'bcrypt'

gem 'sqlite3'

# Use sqlite3 as the database for Active Record
group :development, :test do
#   gem 'sqlite3'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-collection_matchers'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', :require => false
#   gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'coveralls', :require => false
end

group :doc do
  gem 'sdoc', require: false
end

group :production do
#   gem 'pg', '= 0.17.1'
  gem "mysql2"
  gem 'rails_12factor', '= 0.0.2'
end
