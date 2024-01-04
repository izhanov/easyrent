source "https://rubygems.org"

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
gem "vite_rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"
gem "sidekiq", ">= 6.2.0"
gem "sidekiq-scheduler", "~> 5.0.3"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"
gem "shrine", ">= 3.0.0"

gem "devise", ">= 4.8.0"

gem "dry-monads", "~> 1.6"
gem "dry-validation", "~> 1.10"

gem "rails-i18n", "~> 7.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails", "~> 6.1.0"
  gem "factory_bot_rails", "~> 6.2.0"
  gem "byebug"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "annotate", "~> 3.2.0"
  gem "web-console"
  gem "capistrano", require: false
  gem "capistrano-bundler", require: false
  gem "capistrano-rails", require: false
  gem "capistrano-rvm", require: false
  gem "capistrano-passenger", require: false
  gem "capistrano-sidekiq", require: false
  gem "letter_opener"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem "capybara", ">= 3.39"
  gem "cuprite"
  gem "shoulda-matchers", "~> 6.0"
  gem "database_cleaner-active_record"
  gem "faker", "~> 3.2.2"
end
