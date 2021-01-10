# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specifying an exact Ruby version
ruby "2.6.6"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.1"
# Use Puma as the app server
gem "puma", "~> 4.3"
# Use postgreSQL for heroku
gem "pg", ">= 0.20.0"
# Ruby Language Metrics (https://devcenter.heroku.com/articles/language-runtime-metrics-ruby#getting-started)
gem "barnes"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Webpacker is the default JavaScript compiler for Rails 6
gem "webpacker", "~> 4.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 5.0"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5.2", ">= 5.2.1"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.9", ">= 2.9.1"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Logging
# Tame Rails' multi-line logging into a single line per request
gem "lograge", "~> 0.11.2"

# Caching
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false
# Rack::Cache is suitable as a quick drop-in component to enable HTTP caching
gem "rack-cache"
# High performance memcached client for Ruby
gem "dalli"
# Multiple connections are created to MemCachier’s servers
gem "connection_pool"

# Frontend
# Slim allows you to write very minimal templates
gem "slim-rails"
# Use Twitter Bootstrap 4 for stylesheets
gem "bootstrap", "~> 4.4"
# Use jquery as the JavaScript library.
# Bootstrap 4 require jQuery, Popper.js, and our own JavaScript plugins.
gem "jquery-rails"
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for modern web app frameworks and ORMs
gem "kaminari"
# Bootstrap 4 styling for Kaminari
gem "bootstrap4-kaminari-views"

# Provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.
gem "font-awesome-rails"
# Easily add Growl-like notifications
gem "gritter", "~> 1.2"

# Use Faker to easily generate fake data: names, addresses, phone numbers, etc.
gem "faker", "~> 2.8"

# Collection of filters for transforming text into HTML code
gem "auto_html", "~> 2.0"

# simplest and a robust captcha plugin for Google reCAPTCHA API
gem "recaptcha", require: "recaptcha/rails"

# Gem to add cookie consent
gem "cookies_eu"

# Backend
# Authlogic is a clean, simple, and unobtrusive ruby authentication solution
gem "authlogic", "~> 5.0", ">= 5.0.4"
# SCrypt is the default provider for Authlogic
gem "scrypt"
# CanCanCan is an authorization library which restricts what resources a given user is allowed to access
gem "cancancan", "~> 3.0", ">= 3.0.1"

# Use CarrierWave to upload files
gem "carrierwave", "~> 2.0", ">= 2.0.2"
# Use Mini Magick to manipulate images with minimal use of memory
gem "mini_magick", "~> 4.9", ">= 4.9.5"

# Use google drive to upload and download files through cloud services library fog
gem "fog-core", "2.1.0"
gem "fog-google", "~> 1.9", ">= 1.9.1"
gem "google-api-client", "~> 0.23.0"
gem "mime-types"
# Active Storage: Google Cloud Storage Service
gem "google-cloud-storage", "~> 1.11", require: false

# i18n
# Find out which locale the user preferes by reading the languages they specified in their browser
gem "http_accept_language", "~> 2.1"
# Use rails-i18n to get default pluralization and transliteration rules
gem "rails-i18n", "~> 6.0"

# SDK for Facebook. It allows read/write access to the social graph
gem "koala", "~> 3.0"

# Security
# ExceptionHandler replaces Rails' default error pages with dynamic views.
gem "exception_handler", "~> 0.8"
# The simplest way to add honeypot captchas in your Rails forms.
gem "honeypot-captcha"
# A rack middleware for throttling and blocking abusive requests
gem "rack-attack", "~> 5.4", ">= 5.4.2"

group :development, :test do
  # Pry is a powerful alternative to the standard IRB shell for Ruby
  gem "pry-rails"
  # Step-by-step debugging and stack navigation in Pry
  gem "pry-byebug", platform: :ruby
  # Pretty print your Ruby objects with style -- in full color and with proper indentation. Use with 'ap object'
  gem "awesome_print"
  # Use for fighting the N+1 problem in Ruby
  gem "bullet"
  # Shim to load environment variables from .env into ENV
  gem "dotenv-rails"
  # Behaviour Driven Development for Ruby
  gem "rspec-rails"
  # Speedup RSpec + Cucumber by running parallel on multiple CPU cores
  gem "parallel_tests"
  # Annotate guard runs the annotate gem when needed
  gem "guard-annotate", ">= 2.3", require: false
end

group :development do
  # Add a comment summarizing the current schema to the top or bottom of each of your ActiveRecord models, Specs, factory_girl factories...
  gem "annotate", require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  # Better Errors replaces the standard Rails error page with a much better and more useful error page.
  gem "better_errors"
  # necessary to use Better Errors' advanced features
  gem "binding_of_caller", platforms: :ruby
  # Preview email in the default browser instead of sending it.
  gem "letter_opener_web"
  # bundler-audit provides patch-level verification for Bundled apps
  gem "bundler-audit", "~> 0.6.0", require: false
  # Guard is a command line tool to easily handle events on file system modifications
  gem "guard", "~> 2.14", require: false
  # minitest guard runs the minitests when needed
  gem "guard-minitest", "~> 2.4", require: false
  # Bundler guard allows to automatically & intelligently install/update bundle when needed.
  gem "guard-bundler", "~> 2.2", require: false
  # compare licenses against a user-defined whitelist, and give you an actionable exception report
  gem "license_finder", "~> 5.10", ">= 5.10.2", require: false
  # Brakeman is an open source static analysis tool which checks Rails applications for security vulnerabilities.
  gem "brakeman", require: false
  # Use i18n-tasks to find and manage missing and unused translations
  gem "i18n-tasks", "~> 0.9.15", require: false
  # IYE makes it easy to translate your Rails I18N files and keeps them up to date
  gem "iye", require: false
  # setup your favicon
  gem "rails_real_favicon", ">= 0.0.13", require: false # FixMe: https://github.com/RealFaviconGenerator/rails_real_favicon/issues/30
  # RuboCop configuration which has the same code style checking as official Ruby on Rails
  gem "rubocop-rails_config", require: false
  # A RuboCop extension for Faker.
  gem "rubocop-faker", "~> 0.2.0", require: false
  # A plugin for the RuboCop code style enforcing & linting tool.
  gem "rubocop-rspec", "~> 1.36", require: false
  gem "guard-rubocop", require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0"
  # Convert HTML to Slim templates. Because HTML sux and Slim rules. That's why.
  gem "html2slim", require: false
end

group :test do
  # bring back the original controller testing for Authlogic
  gem "rails-controller-testing", "~> 1.0"
  # Strategies for cleaning databases in Ruby. Can be used to ensure a clean state for testing.
  gem "database_cleaner"
  # Code coverage for Ruby
  gem "simplecov", require: false
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  gem "shoulda-matchers", "~> 4.1", ">= 4.1.2"
  # RSpec::CollectionMatchers lets you express expected outcomes on collections of an object in an example
  gem "rspec-collection_matchers"
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

if Gem.win_platform?
  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
  # to avoid polling for changes
  gem "wdm", ">= 0.1.0"
end
