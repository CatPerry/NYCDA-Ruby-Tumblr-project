source "https://rubygems.org"

gem "sinatra"
gem "sinatra-flash"
gem "activerecord"
gem "sinatra-activerecord"
gem "rake"
gem 'bootstrap', '~> 4.1.1'

group :development do
  gem "sqlite3"
end

group :production do
  # our pg gem will only be used on production
  #   the pg gem is an adapter for postgresql
  gem "pg"
end