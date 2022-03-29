# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.4', '>= 6.0.4.1'

# Data
gem 'mongoid', '~> 7.3.0'
gem 'mongoid-history'
gem 'mongoid-uuid'
gem 'time_difference'

# API
gem 'jsonapi-serializer'
gem 'oj'
gem 'restful-jsonapi', git: 'https://github.com/acceptly/restful-jsonapi', branch: 'support-rails-6'

# AUTHORIZATION
gem 'pundit'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop', require: false
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'ffaker'
  gem 'pundit-matchers'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :production do
  gem 'rails_12factor'
end

# Server
gem 'aasm'
gem 'bootsnap', require: false
gem 'lograge'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'remote_syslog_logger'
gem 'tzinfo-data'
