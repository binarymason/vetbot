module VetBot
  class << self
    def handle_message(data)
      puts data unless ENV["RACK_ENV"] == "test"

      return unless spoken_to?(data)

      VetBot.typing channel: data.channel
      message = select_response(data)

      VetBot.message(channel: data.channel, text: message) if message
    end

    private

    def spoken_to?(data)
      data.text&.match(VetBot.id) || direct_message?(channel: data.channel)
    end

    def direct_message?(channel:)
      direct_messages.include? channel
    end

    def direct_messages
      client.ims&.keys || []
    end

    def select_response(data)
      case data.text
      when /ruby|rails/i then
        VetBot.formatted_resources "ruby"
      when /hi|hello|hey/i then
        "Hi <@#{data.user}>!"
      else
        idk_response
      end
    end

    def idk_response
      "Sorry, I'm not smart enough yet to answer that. " \
        "Maybe post in the <##{channel('general')}|general> " \
        "or <##{channel('web-dev')}|web-dev> channel " \
        "so a human can assist."
    end

    def channels
      client.channels
    end

    # Returns a channel id.  Returns nil if channel doesn't exist.
    def channel(name)
      obj = channels.select do |_k, hsh|
        hsh["name"].to_s.casecmp(name.to_s).zero?
      end

      obj&.keys&.first
    end
  end
end
