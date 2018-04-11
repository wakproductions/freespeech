source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'slim'
# gem 'turbolinks', '~> 5'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'

gem 'bootstrap-sass'

gem 'ipfs'
gem 'nokogiri'
gem 'radiator'#, path: '~/Development/radiator'
gem 'typhoeus'
gem 'verbalize'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'clipboard'
  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

