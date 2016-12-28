require "yaml"

module VetBot
  class << self
    def resources(target = nil)
      return unless target

      resource = target.downcase.tr(" ", "_")
      path = "resources/#{resource}.yml"
      return unless File.exist? path

      YAML.load_file(path)
    end
  end
end
