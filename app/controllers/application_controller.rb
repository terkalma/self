class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :set_date

  def publish_keen(collection: , event:)
    server_info = { host: request.host }
    ensure_em
    Keen.try :publish_async, collection, { server: server_info }.merge(event)
  rescue
    # don't care about +Keen+ errors
  end

  def publish_screenr(collection: , event:)
    server_info = { host: request.host }
    Analytics::Screenr.new.publish collection, { server: server_info }.merge(event)
  end

  private
  def set_date
    current_user
    @date = Date.strptime(params[:date]) rescue Date.today
  end
end
