require "spec_helper"

RSpec.describe "VetBot resources commands" do
  subject(:bot) { VetBot }

  describe "#resources" do
    it "returns nil if not given an argument" do
      expect(bot.resources).to be_nil
    end

    it "loads a hash from a YAML file based off argment" do
      path = File.join("resources/ruby.yml")
      expect(File.exist?(path)).to be true

      resources = bot.resources("ruby")
      expect(resources).to_not be_nil
      expect(resources).to respond_to(:keys)
    end

    it "returns nil if a resource YAML file is not available" do
      expect(File).to receive(:exist?).and_return(false)
      expect(bot.resources("ruby")).to be_nil
    end
  end
end
