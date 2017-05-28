class Sessions < Controller
  def routes
    on "login" do
      post do
        user_name = form_params["user_name"].as(String)

        user = Repo.get_by(User, name: user_name)
        return "user not found" unless user

        session["user_id"] = user.id.to_s

        redirect "/races"
      end
    end

    on "logout" do
      post do
        session.delete("user_id")

        redirect "/races"
      end
    end
  end
end
