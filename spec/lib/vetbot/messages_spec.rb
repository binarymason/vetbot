require "spec_helper"

RSpec.describe "VetBot messages" do
  subject(:bot) { VetBot }
  let(:data) do
    double(:data, type: "message", channel: channel, text: text, user: "tester")
  end

  let(:text) { "this is a message" }
  let(:vet_bot_id) { "vet_bot_id" }

  before :example do
    # Stub out web client request that fetches id
    allow(VetBot).to receive(:id).and_return vet_bot_id

    # No point in this during testing
    allow(VetBot).to receive(:typing).and_return(nil)
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

  context "and mentioned" do
    let(:channel) { "1123foobarz" }
    let(:text) { "Hey there, #{vet_bot_id}. I'm mentioning you." }

    it "VetBot responds when @mentioned" do
      expect(VetBot).to receive(:message).with(
        channel: data.channel,
        text:    anything
      )

      VetBot.handle_message(data)
    end
  end
end
