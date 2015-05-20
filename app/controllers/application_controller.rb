class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_filter :set_date

  def publish_keen(collection: , event:)
    server_info = { host: request.host }
    ensure_em
    Keen.try :publish_async, collection, { server: server_info }.merge(event)
  rescue
    # don't care about +Keen+ errors
  end

  private
  def set_date
    @date = Date.strptime(params[:date]) rescue Date.today
  end
end
