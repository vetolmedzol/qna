source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'kaminari'
gem 'popper_js', '~> 1.9', '>= 1.9.9'
gem 'rails-ujs'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'haml-rails', '~> 2.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 3.26'
  gem 'capybara-webkit', '~> 1.11', '>= 1.11.1'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker', '~> 2.19'
  gem 'geckodriver-helper'
  gem 'parallel_tests', '~> 2.7'
  gem 'pry', '~> 0.13.1'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'spring-commands-parallel-tests', '~> 1.0', '>= 1.0.1'
  gem 'webrick', '~> 1.3', '>= 1.3.1'
end

group :development do
  gem 'guard-bundler', '~> 2.2', '>= 2.2.1', require: false
  gem 'guard-rails', '~> 0.7.2', require: false
  gem 'guard-rspec', '~> 4.7', '>= 4.7.3', require: false
  gem 'guard-spring', '~> 1.1', '>= 1.1.1', require: false
  gem 'spring-commands-rspec', require: false

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'fuubar', '~> 2.0'
  gem 'rack_session_access', '~> 0.2.0'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
