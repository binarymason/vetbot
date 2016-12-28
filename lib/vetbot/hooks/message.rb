VetBot.on :message do |data|
  puts data

  VetBot.typing channel: data.channel

  case data.text
  when "bot hi" then
    VetBot.message channel: data.channel, text: "Hi <@#{data.user}>!"
  when /^bot/ then
    VetBot.message channel: data.channel, text: "Sorry <@#{data.user}>, what?"
  end
end
