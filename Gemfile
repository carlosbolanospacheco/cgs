source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'

gem 'bootstrap-sass'
gem 'cancancan'
gem 'cocoon'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'modernizr-rails'
gem 'paperclip', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails_admin', '>= 1.0.0.rc'
gem 'remotipart', '~> 1.2'
gem 'sass-rails', '~> 5.0'
gem 'toastr-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Generacion de PDF
gem 'pdfkit'
gem 'render_anywhere'
gem 'wkhtmltopdf-binary'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Access an IRB console on exception pages or by using
  # <%= console %> anywhere in the code.
  gem 'rubocop', '~> 0.48.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'yard'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
