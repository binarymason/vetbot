require "slack-ruby-client"

# Singleton wrapper for any Slack Client methods used.
# Useful for portability reasons.
module VetBot
  class << self
    SLACK_API_TOKEN = ENV.fetch("SLACK_API_TOKEN")

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

    def id
      @id ||= begin
                response = web_client.users_info(user: "@vetbot")
                response.dig("user", "id")
              end
    end

    private

    # Only expose an interface that we own.
    # Any client methods that are needed should be wrapped in a public method.
    def client
      @client ||= Slack::RealTime::Client.new(token: SLACK_API_TOKEN)
    end

    # Web Client is useful for methods that are not supported
    # in Slack's Real Time Messaging API.
    def web_client
      client.web_client
    end
  end
end

# Require additional functionality after VetBot is defined.
require "vetbot/resources"
require "vetbot/hooks"
