source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'

gem 'bootstrap-sass', '~> 3.3.7'
gem 'cancancan', '~> 1.16.0'
gem 'cocoon', '~> 1.2.9'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.2.1'
gem 'jbuilder', '~> 2.6.3'
gem 'jquery-rails', '~> 4.3.1'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'modernizr-rails', '~> 2.7.1'
gem 'paperclip', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails_admin', '>= 1.0.0.rc'
gem 'remotipart', '~> 1.2'
gem 'sass-rails', '~> 5.0'
gem 'toastr-rails', '~> 1.0.3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Generacion de PDF
gem 'pdfkit', '~> 0.8.2'
gem 'render_anywhere', '~> 0.0.12'
gem 'wkhtmltopdf-binary', '~> 0.12.3.1'

group :development, :test do
  gem 'byebug', '~> 9.0.6'
  gem 'rspec-rails', '~> 3.6.0'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Access an IRB console on exception pages or by using
  # <%= console %> anywhere in the code.
  gem 'rubocop', '~> 0.48.1', require: false
  gem 'spring', '~> 2.0.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'yard', '~> 0.9.8'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2.3', platforms: %i[mingw mswin x64_mingw jruby]
