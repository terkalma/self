class RoomsController < ApplicationController
  def index
    @messages = Message.limit(100).order('created_at DESC').all.sort_by {|m| m.created_at}
  end
end