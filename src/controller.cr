class Controller < Toro::Router
  def form_params
    @parsed_params ||= begin
      body_str = context.request.body.try(&.gets_to_end) || ""
      HTTP::Params.parse(body_str)
    end
  end

  def session
    context.session
  end


  @current_user : User?

  def current_user?
    @current_user ||= begin
      if user_id = session["user_id"]?
        Repo.get(User, user_id)
      end
    end
  end

  def current_user
    current_user?.not_nil!
  end

  macro assert_user_logged_in
    redirect "/races" && return unless current_user?
  end


  def routes
  end
end
