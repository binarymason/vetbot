require_relative "initialize"
require_relative "web"

Thread.abort_on_exception = true

Thread.new do
  begin
    VetBot.start!
  rescue Exception => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run VetBot::Web
