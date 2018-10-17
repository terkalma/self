class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_date

  private
  def set_date
    current_user
    @date = Date.strptime(params[:date]) rescue Date.today
  end
end
