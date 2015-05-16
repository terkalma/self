class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def publish_keen(collection: , event:)
    server_info = { host: request.host }
    ensure_em
    Keen.try :publish_async, collection, { server: server_info }.merge(event)
  end

end
