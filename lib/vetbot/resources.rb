require "yaml"

module VetBot
  class << self
    # Returns a single string separated by newlines.
    # Sections are the top level key in the YAML file, ie: "Books".
    def formatted_resources(target)
      hsh = resources(target)
      return "No resources exist for #{target} yet" unless hsh

      response = ""
      hsh.keys.each do |section|
        arr = format_items(hsh, section)

        title = "Recommended #{section} are:"
        arr.unshift(title)
        response += arr.join("\n")
      end

      response
    end

    # Returns a hash from whatever is target YAML file.
    # Returns nil if target file does not exist
    def resources(target = nil)
      return unless target

      resource = target.downcase.tr(" ", "_")
      path = "resources/#{resource}.yml"
      return unless File.exist? path

      YAML.load_file(path)
    end

    private

    # Default format is "some key: some value, another key: another value".
    #
    # Custom formats can be defined as a private method and used for a
    # specific section by placing in case statement.
    #
    def format_items(hsh, section)
      case section
      when "Books"
        books(hsh[section])
      else
        hsh[section].map do |items|
          items.map { |k, v| "#{k}: #{v}" }.join(", ")
        end
      end
    end

    def books(array_of_hashes)
      array_of_hashes.map do |hsh|
        "#{hsh['title']} by #{hsh['author']} (#{hsh['link']})"
      end
    end
  end
end
