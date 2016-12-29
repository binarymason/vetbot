require "spec_helper"

RSpec.describe "VetBot introduction" do
  subject(:bot) { VetBot }
  let(:data) do
    { "user" => { "id" => user_id, "name" => "Some User" } }
  end

  let(:user_id) { "some_user_id" }
  let(:web_client) { double(:web_client) }
  let(:channel_id) { "some_channel_id" }
  let(:response) do
    { "channel" => { "id" => channel_id, "name" => "FooBar" } }
  end

  before :example do
    allow(VetBot).to receive(:web_client).and_return(web_client)
  end

  context "and a new user joins Slack" do
    it "VetBot immediately greets the user via Direct Message" do
      expect(web_client).to receive(:im_open)
        .with(user: user_id)
        .and_return(response)

      expect(VetBot).to receive(:message).with(
        channel: channel_id, text: anything
      )

      VetBot.handle_team_join(data)
    end
  end
end
