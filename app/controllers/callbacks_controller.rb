class CallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    begin
      @user = User.from_oauth request.env["omniauth.auth"]

      sign_in_and_redirect @user
    rescue ActiveRecord::RecordInvalid => e
      flash['alert'] = e.message
      redirect_to :new_user_session
    end
  end
end