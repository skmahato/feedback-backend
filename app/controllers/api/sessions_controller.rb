class Api::SessionsController < Api::ApiController
    skip_before_action :login_required
  
    def create
      user = User.find_by(email: params[:email])
  
      if user&.valid_password?(params[:password])
        jwt_token = Auth.issue(user: user.id)
        render_success(:ok, user, meta: { jwt_token: jwt_token, message: I18n.t("devise.sessions.signed_in") })
      else
        render_error(:not_found, [I18n.t("devise.failure.not_found_in_database")])
      end
    end
  end
  