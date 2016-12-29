require "vetbot/messages"

VetBot.on :message do |data|
  VetBot.handle_message(data)
end
