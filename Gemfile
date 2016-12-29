source "http://rubygems.org"

ruby "2.3.3"

gem "slack-ruby-client"

gem "celluloid-io", require: ["celluloid/current", "celluloid/io"]
gem "foreman"
gem "puma"
gem "sinatra"

group :development do
  gem "pry"
  gem "rubocop", require: false
  gem "rubocop-rspec"
  gem "guard-rspec", require: false
end

gem "dotenv", groups: %i(development test)

group :test do
  gem "rspec"
end
