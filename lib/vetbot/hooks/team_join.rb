VetBot.on :team_join do |data|
  VetBot.message channel: data.channel, text: "Hi <@#{data.user}>!"
end
