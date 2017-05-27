require "toro"

require "./repo"

require "./models/*"
require "./helpers/*"


require "./controllers/*"

class App < Toro::Router
  def routes
    on "races" do
      mount Races
    end

    on "users" do
      mount Users
    end
  end
end

App.run("0.0.0.0", 3000, [
  HTTP::LogHandler.new,
  HTTP::StaticFileHandler.new("src/public/")
])
