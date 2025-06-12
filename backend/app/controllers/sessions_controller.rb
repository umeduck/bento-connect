require 'jwt'

class SessionsController < ApplicationController
  def slack_redirect
    redirect_to '/auth/slack' # Placeholder: Redirect to Slack authorization
  end

  def slack_callback
    auth = request.env["omniauth.auth"]
    return render json: { error: "OAuth failed" }, status: :unprocessable_entity unless auth

    # Assuming User model exists and has uid, name, and image_url attributes
    user = User.find_or_initialize_by(uid: auth.uid)
    user.update!(name: auth.info.name, image_url: auth.info.image)
    token = JWT.encode(
      { user_id: user.id, exp: 15.days.from_now.to_i },
      ENV.fetch("JWT_SECRET"),
      "HS256"
    )

    front_base = ENV.fetch("FRONT_BASE_URL", "http://localhost:5173")
    redirect_to "#{front_base}/oauth?token=#{token}"
  end
end