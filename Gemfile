source "http://rubygems.org"

gem "slack-ruby-client"

gem "celluloid-io", require: ["celluloid/current", "celluloid/io"]
gem "foreman"

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
