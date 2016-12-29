require "vetbot/introduction"

VetBot.on :team_join do |data|
  VetBot.handle_team_join(data)
end
