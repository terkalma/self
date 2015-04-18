class WelcomeController < ApplicationController
  before_filter :set_date

  def index
  end

  private
  def set_date
    @date = Date.strptime(params[:date]) rescue Date.today
  end
end
