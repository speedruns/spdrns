require "kemal"
require "krout"

require "spdrns"
include SpdRns

require "./helpers/*"
require "./controllers/*"


public_folder "src/public"


scope "/races" do
  get "",                     &->RacesController.index(Krout::Env)
  get "/create",              &->RacesController.create(Krout::Env)
  get "/:id",                 &->RacesController.show(Krout::Env)
  get "/:id/join/:username",  &->RacesController.join(Krout::Env)
  get "/:id/done/:username",  &->RacesController.done(Krout::Env)
  get "/:id/open",            &->RacesController.open(Krout::Env)
  get "/:id/close",           &->RacesController.close(Krout::Env)
  get "/:id/start",           &->RacesController.start(Krout::Env)
  get "/:id/pause",           &->RacesController.pause(Krout::Env)
  get "/:id/finish",          &->RacesController.finish(Krout::Env)
  get "/:id/cancel",          &->RacesController.cancel(Krout::Env)
end


Kemal.run
