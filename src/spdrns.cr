require "toro"
require "session"

require "./repo"

require "./models/*"
require "./helpers/*"


require "./controller"
require "./controllers/*"

class App < Controller
  def routes
    on "races" do
      mount Races
    end

    on "users" do
      mount Users
    end

    mount Sessions
  end
end

session_handler = Session::Handler(Hash(String, String)).new(secret: "SUPERSECRET")

App.run("0.0.0.0", 3000, [
  HTTP::LogHandler.new,
  HTTP::StaticFileHandler.new("src/public/"),
  session_handler
])
