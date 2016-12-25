require "kemal"
require "krout"

require "spdrns"
include SpdRns

require "./helpers/*"
require "./controllers/*"


public_folder "src/public"

scope "/races" do
  get   "",                     &->RacesController.index(Krout::Env)
  post  "/create",              &->RacesController.create(Krout::Env)
  get   "/:id",                 &->RacesController.show(Krout::Env)
  post  "/:id/join/:username",  &->RacesController.join(Krout::Env)
  post  "/:id/done/:username",  &->RacesController.done(Krout::Env)
  post  "/:id/open",            &->RacesController.open(Krout::Env)
  post  "/:id/close",           &->RacesController.close(Krout::Env)
  post  "/:id/start",           &->RacesController.start(Krout::Env)
  post  "/:id/pause",           &->RacesController.pause(Krout::Env)
  post  "/:id/finish",          &->RacesController.finish(Krout::Env)
  post  "/:id/cancel",          &->RacesController.cancel(Krout::Env)
end


Kemal.run
