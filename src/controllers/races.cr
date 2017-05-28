class Races < Controller
  def routes
    get do
      races = Repo.all(Race, preload: [:memberships, :users])
      html "src/templates/races/index.html"
    end

    on "create" do
      post do
        race = Race.new
        changeset = Repo.insert(race)

        redirect "/races"
      end
    end

    on :id do
      race = Repo.get!(Race, inbox[:id], Query.preload(:memberships))

      get do
        html "src/templates/races/show.html"
      end

      on "join" do
        post do
          assert_user_logged_in
          membership = Membership.participant(current_user, race)
          Repo.insert(membership)

          redirect "src/templates/races/#{race.id}"
        end
      end

      on "ready" do
        post do
          assert_user_logged_in

          membership = Repo.get_by!(Membership, user_id: current_user.id, race_id: race.id)
          membership.ready
          Repo.update(membership)

          redirect "/races/#{race.id}"
        end
      end

      on "done" do
        post do
          assert_user_logged_in

          membership = Repo.get_by!(Membership, user_id: current_user.id, race_id: race.id)
          membership.done
          Repo.update(membership)

          redirect "/races/#{race.id}"
        end
      end

      on "open" do
        post do
          race.open
          Repo.update(race)

          redirect "/races/#{race.id}"
        end
      end

      on "close" do
        post do
          race.close
          Repo.update(race)

          redirect "/races/#{race.id}"
        end
      end

      on "start" do
        post do
          race.start
          Repo.update(race)

          redirect "/races/#{race.id}"
        end
      end

      on "pause" do
        post do
          race.pause
          Repo.update(race)

          redirect "/races/#{race.id}"
        end
      end

      on "finish" do
        post do
          race.finish
          Repo.update(race)

          redirect "/races/#{race.id}"
        end
      end

      on "cancel" do
        post do
          race.cancel
          Repo.update(race)

          redirect "/races/#{race.id}"
        end
      end
    end
  end
end
