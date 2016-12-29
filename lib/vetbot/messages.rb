module VetBot
  class << self
    def handle_message(data)
      puts data

      return unless spoken_to?(data)

      VetBot.typing channel: data.channel
      message = select_response(data)

      VetBot.message(channel: data.channel, text: message) if message
    end

    private

    def spoken_to?(data)
      data.text.match(VetBot.id) || direct_message?(channel: data.channel)
    end

    def direct_message?(channel:)
      direct_messages.include? channel
    end

    def direct_messages
      client.ims&.keys || []
    end

    def select_response(data)
      case data.text
      when /hi|hello|hey/ then
        "Hi <@#{data.user}>!"
      else
        "Sorry, I'm not smart enough yet"
      end
    end
  end
end
