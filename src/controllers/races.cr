class Races < Toro::Router
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
        on :username do
          post do
            user = Repo.get_by!(User, name: inbox[:username])
            membership = Membership.participant(user, race)
            Repo.insert(membership)

            redirect "src/templates/races/#{race.id}"
          end
        end
      end

      on "ready" do
        on :username do
          post do
            user = Repo.get_by!(User, name: inbox[:username])
            membership = Repo.get_by!(Membership, user_id: user.id, race_id: race.id)
            membership.ready
            Repo.update(membership)

            redirect "/races/#{race.id}"
          end
        end
      end

      on "done" do
        on :username do
          post do
            user = Repo.get_by!(User, name: inbox[:username])
            membership = Repo.get_by!(Membership, user_id: user.id, race_id: race.id)
            membership.done
            Repo.update(membership)

            redirect "/races/#{race.id}"
          end
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
