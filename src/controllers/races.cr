class RacesController
  class DB
    @@races : Hash(String, Race) = {} of String => Race
    @@users : Hash(String, User) = {} of String => User

    def self.races
      @@races ||= {} of String => Race
    end

    def self.users
      @@users ||= {} of String => User
    end
  end

  def self.index(env)
    env.response.content_type = "text/html"

    races = DB.races
    render2("races/index.html")
  end

  def self.create(env)
    env.response.content_type = "text/html"

    # Guarantee a locally-unique key
    id = SecureRandom.hex(4)
    while DB.races.has_key?(id)
      id = SecureRandom.hex(4)
    end

    race = Race.new(id)
    DB.races[race.id] = race

    env.redirect("/races")
  end

  def self.show(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    race = DB.races[race_id]

    render2("races/show.html")
  end

  def self.join(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    user_name = env.params.url["username"]

    race = DB.races[race_id]
    user = DB.users[user_name]? || (DB.users[user_name] = User.new(user_name))
    user.register(race)
    user.ready(race)

    env.redirect("/races/#{race.id}")
  end

  def self.done(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    user_name = env.params.url["username"]

    race = DB.races[race_id]
    user = DB.users[user_name]
    user.done(race)

    env.redirect("/races/#{race.id}")
  end

  def self.open(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    race = DB.races[race_id]

    race.open
    env.redirect("/races/#{race.id}")
  end

  def self.close(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    race = DB.races[race_id]

    race.close
    env.redirect("/races/#{race.id}")
  end

  def self.start(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    race = DB.races[race_id]

    race.start
    env.redirect("/races/#{race.id}")
  end

  def self.pause(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    race = DB.races[race_id]

    race.pause
    env.redirect("/races/#{race.id}")
  end

  def self.finish(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    race = DB.races[race_id]

    race.finish
    env.redirect("/races/#{race.id}")
  end

  def self.cancel(env)
    env.response.content_type = "text/html"
    race_id = env.params.url["id"]
    race = DB.races[race_id]

    race.cancel
    env.redirect("/races/#{race.id}")
  end
end
