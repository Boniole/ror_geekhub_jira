source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Use Json Web Token (JWT) for token based authentication
gem 'jwt'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"
gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false

gem 'figaro'

gem 'ed25519'

gem 'bcrypt_pbkdf'

# Gem for authorization system
gem 'pundit'

# Gems for authentication system
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'rspec-rails'
gem 'rswag'
gem 'rswag-specs'

# ActiveModelSerializers brings convention over configuration to your JSON generation. [https://github.com/rails-api/active_model_serializers/tree/0-10-stable]
gem 'active_model_serializers', '~> 0.10.0'

# connect to amazon S3
gem 'aws-sdk-s3', require: false

# for passwords in .env file
gem 'dotenv-rails'

# Octokit.rb wraps the GitHub API in a flat API [https://github.com/octokit/octokit.rb]
gem 'octokit', '~> 5.0'

# Faraday is an HTTP client library abstraction layer that provides a common interface over many adapters
gem 'faraday'
gem 'faraday-retry'

# A thread safe Ruby client for the NATS messaging system written in pure Ruby. [https://github.com/nats-io/nats-pure.rb]
gem 'nats-pure'

# It is a simple library allowing you to transliterate between cyrillic and latin. It is easy to use from the command line and in your code.
gem 'translit'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-nginx'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-upload-config'
  gem 'sshkit-sudo'

  gem 'annotate'
  gem 'ffaker', '~> 2.21'
end
