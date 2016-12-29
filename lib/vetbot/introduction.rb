module VetBot
  class << self
    def handle_team_join(data)
      user_id = data&.user&.id
      channel = open_direct_message_with_user(user_id: user_id)
      return unless channel

      VetBot.message channel: channel, text: introduction(user_id: user_id)
    end

    def introduction(user_id:)
      "Hi <@#{user_id}>, I'm VetBot of Operation Code here to assist and "\
        "guide you towards some resources to get coding. What programming "\
        "languages are you interested in learning so that I can tailor some "\
        "solutions for you?"
    end

    private

    # Opens a direct message channel and returns channel id.
    def open_direct_message_with_user(user_id:)
      response = web_client.im_open(user: user_id)
      response.dig("channel", "id")
    end
  end
end
