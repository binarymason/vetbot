require "spec_helper"

RSpec.describe "VetBot messages" do
  subject(:bot) { VetBot }
  let(:data) do
    double(:data, type: "message", channel: channel, text: text, user: user)
  end

  let(:text) { "this is a message" }
  let(:vetbot_id) { "vetbot_id" }
  let(:channel) { "1123foobarz" }
  let(:user) { "some_user" }

  let(:users) do
    {
      "some_user"    => { "id" => "some_user", "name" => "Some User" },
      "another_user" => { "id" => "another_user", "name" => "Another User" },
      "vetbot"       => { "id" => vetbot_id, "name" => "vetbot" }
    }
  end
  let(:client) { double(:client, ims: {}, users: users) }

  before :example do
    # Stub out web client request that fetches id
    allow(VetBot).to receive(:id).and_return vetbot_id

    # No point in this during testing
    allow(VetBot).to receive(:typing).and_return(nil)

    # Specify Slack Client behavior for testing purposes
    allow(VetBot).to receive(:client).and_return(client)
  end

  context "and given a direct message" do
    let(:channel) { "dm" }

    it "VetBot always responds to DMs" do
      allow(VetBot).to receive(:direct_messages).and_return([channel])
      expect(VetBot).to receive(:message).with(
        channel: data.channel,
        text:    anything
      )

      VetBot.handle_message(data)
    end
  end

  context "and a message from VetBot gets posted as an event" do
    let(:user) { "vetbot" }

    it "VetBot does NOT respond to its own messages" do
      expect(VetBot).to_not receive(:message)

      VetBot.handle_message(data)
    end
  end

  context "and mentioned" do
    let(:text) { "Hey there, #{vetbot_id}. I'm mentioning you." }

    it "VetBot responds when @mentioned" do
      expect(VetBot).to receive(:message).with(
        channel: data.channel,
        text:    anything
      )

      VetBot.handle_message(data)
    end
  end
end
