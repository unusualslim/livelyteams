source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '3.1.1'

#gem 'rails', '~> 6.0.3.1'
#gem 'rails', '~> 6.1', '>= 6.1.6'
gem 'rails', '~> 7.0', '>= 7.0.3'
gem 'pg', '~> 1.3', '>= 1.3.5'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'twilio-ruby', '~> 5.58'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

gem 'ransack', '~>3.2.0'

#gem 'pg', '~> 0.18'
#gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
#gem 'puma', '~> 3.7'
#gem 'puma', '~> 4.3', '>= 4.3.1'
gem 'puma', '~> 5.6', '>= 5.6.4'
gem 'bootsnap', require: false
#gem 'bootstrap', '~> 4.5.2'
# gem 'sass-rails', '>= 3.2'
#gem 'jquery-rails'
#gem 'uglifier', '>= 1.3.0'
#gem 'coffee-rails', '~> 5.0'
#gem 'turbolinks', '~> 5'
#gem 'jbuilder', '~> 2.5'
gem 'devise'

gem 'font-awesome-rails'
gem 'mini_magick'
gem 'image_processing', '~> 1.2'
gem 'aws-sdk-s3', '~> 1.112'
# gem 'poppler', '~> 3.5', '>= 3.5.1'
# gem 'mini_magick'
# gem 'mini_racer'
# gem 'aws-sdk', '~> 3.0', '>= 3.0.1'
# gem 'webpacker'
#gem 'poppler', '~> 3.0', '>= 3.0.7'
#gem 'net-smtp', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
#  gem 'capistrano', "~> 3.14",   require: false
#  gem 'capistrano-rbenv',        require: false
#  gem 'capistrano-rails',        require: false
#  gem 'capistrano-bundler',      require: false
#  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
#  gem 'highline'
#  gem 'capistrano-passenger', '>= 0.1.1'


  gem 'web-console', '>= 3.3.0'
  gem 'webrick', '~> 1.7'
#  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
#  gem 'spring'
#  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'dotenv-rails'
