source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',                    '5.0.1'
# Use Puma as the app server
gem 'puma',                     '3.4.0'
# Use SCSS for stylesheets
gem 'sass-rails',               '5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier',                 '3.0.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails',             '4.2.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails',             '4.1.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks',               '5.0.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder',                 '2.4.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt',                   '3.1.11'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'listen'
gem 'bootstrap-sass',           '3.3.6'
gem 'faker',                    '1.6.6'
gem 'will_paginate',            '3.1.0'
gem 'bootstrap-will_paginate',  '0.0.10'
gem 'bootstrap_form'
gem 'bootstrap-table-rails'
gem 'pry'

group :development, :test do
  gem 'airbrake', '~> 6.1'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug',                 '9.0.0', platform: :mri
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3',                '1.3.12'
  gem 'rails-controller-testing', '0.1.1'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'minitest-reporters',     '1.1.9'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console',              '3.1.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',                   '1.7.2'
  gem 'spring-watcher-listen',    '2.0.0'
end

group :production do
  gem 'pg',                     '0.18.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
