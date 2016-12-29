if ENV["RACK_ENV"] != "production"
  require "dotenv"
  Dotenv.load
end

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "vetbot"
