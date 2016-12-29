require "sinatra/base"

module VetBot
  class Web < Sinatra::Base
    get "/" do
      "VetBot is running..."
    end
  end
end
