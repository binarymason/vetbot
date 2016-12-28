require "spec_helper"

RSpec.describe "VetBot resources commands" do
  subject(:bot) { VetBot }
  let(:ruby_resources) { File.join("resources/ruby.yml") }

  describe "#resources" do
    it "returns nil if not given an argument" do
      expect(bot.resources).to be_nil
    end

    it "loads a hash from a YAML file based off argment" do
      expect(File.exist?(ruby_resources)).to be true

      resources = bot.resources("ruby")
      expect(resources).to_not be_nil
      expect(resources).to respond_to(:keys)
    end

    it "returns nil if a resource YAML file is not available" do
      expect(File).to receive(:exist?).and_return(false)
      expect(bot.resources("ruby")).to be_nil
    end
  end

  describe "#formatted_resources" do
    let(:resources) do
      {
        "Books" => Array.new(3) do |i|
          {
            "author" => "author#{i}",
            "title"  => "title#{i}",
            "link"   => "link#{i}"
          }
        end
      }
    end

    it "returns a message if there are not any resources" do
      expect(bot).to receive(:resources).and_return(nil)
      response = bot.formatted_resources("foo")
      expect(response).to eq("No resources exist for foo yet")
    end

    it "returns a single string separated by newlines" do
      expected_str = \
        "Recommended Books are:\n" \
        "title0 by author0 (link0)\n" \
        "title1 by author1 (link1)\n" \
        "title2 by author2 (link2)"

      expect(bot).to receive(:resources).and_return(resources)
      response = bot.formatted_resources("foo")
      expect(response).to eq(expected_str)
    end
  end
end
