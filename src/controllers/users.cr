class Users < Toro::Router
  def form_params
    body_str = context.request.body.try(&.gets_to_end) || ""
    @parsed_params ||= HTTP::Params.parse(body_str)
  end

  def routes
    get do
      users = Repo.all(User, Query.new.preload(:memberships))
      html "src/templates/users/index.html"
    end

    on "signup" do
      get do
        html "src/templates/users/signup_form.html"
      end
    end

    on "create" do
      post do
        user_name = form_params["user_name"].as(String)

        user = User.new(user_name)
        changeset = Repo.insert(user)

        json changeset.errors
      end
    end
  end
end
