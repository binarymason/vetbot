require "slack-ruby-client"

SLACK_API_TOKEN = ENV.fetch("SLACK_API_TOKEN")

# Singleton wrapper for any Slack Client methods used.
# Useful for portability reasons.
module VetBot
  class << self
    def client
      @client ||= Slack::RealTime::Client.new(token: SLACK_API_TOKEN)
    end

    def message(opts = {})
      client.message(opts)
    end

    def on(event, &block)
      client.on(event, &block)
    end

    def start!
      client.start!
    end

    def typing(opts = {})
      client.typing(opts)
    end
  end
end

require_relative "vetbot/hooks"
