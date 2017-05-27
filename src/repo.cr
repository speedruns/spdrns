require "pg"
require "crecto"

module Repo
  extend Crecto::Repo

  config do |conf|
    conf.adapter  = Crecto::Adapters::Postgres
    conf.database = "spdrns"
    conf.hostname = "localhost"
    conf.username = "root"
    conf.password = ""
    conf.port = 5432
  end

end

Query = Crecto::Repo::Query

Crecto::DbLogger.set_handler(STDOUT)
