source 'https://rubygems.org'

ruby '2.1.1'

gem 'rails',        '4.1.0'
gem 'pg'
gem 'sass-rails',   '~> 4.0.3'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-cookie-rails'
gem 'jbuilder',     '~> 2.0'
gem 'sdoc',         '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt',       '~> 3.1.7'

gem 'haml-rails'
gem 'email_validator'
gem 'active_model_serializers'
gem 'bootstrap-sass'
gem 'kaminari-bootstrap'
gem 'rails-i18n'

gem 'ember-rails'
gem 'emblem-rails'

gem 'unicorn'
gem 'feedjira'
gem 'sanitize'

group :test do
  gem 'simplecov',      require: false
  gem 'simplecov-rcov', require: false
end

group :development, :test do
  #gem 'spring'
  gem 'pry'
  gem 'pry-remote'
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  # HACK: https://github.com/thoughtbot/shoulda-matchers/issues/408
  gem 'minitest'
  gem 'shoulda'
  gem 'database_cleaner'
end

group :development do
  gem 'foreman'
  gem 'guard-rspec'
end

group :production do
  gem 'therubyracer'
end
