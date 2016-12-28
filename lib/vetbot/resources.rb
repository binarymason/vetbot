require "yaml"

module VetBot
  class << self
    def formatted_resources(target)
      hsh = resources(target)
      return "No resources exist for #{target} yet" unless hsh

      response = ""
      hsh.keys.each do |section|
        title = "Recommended #{section} are:"

        arr = case section
              when "Books"
                books(hsh[section])
              else
                hsh[section].map do |items|
                  items.map { |k, v| "#{k}: #{v}" }.join(", ")
                end
              end

        arr.unshift(title)
        response += arr.join("\n")
      end

      response
    end

    def resources(target = nil)
      return unless target

      resource = target.downcase.tr(" ", "_")
      path = "resources/#{resource}.yml"
      return unless File.exist? path

      YAML.load_file(path)
    end

    private

    def books(array_of_hashes)
      array_of_hashes.map do |hsh|
        "#{hsh['title']} by #{hsh['author']} (#{hsh['link']})"
      end
    end
  end
end
