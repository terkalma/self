class WelcomeController < ApplicationController
  before_filter :set_date

  def index
  end

  private
  def set_date
    begin
      @date = Date.strptime params[:date]
    rescue
      @date = Date.today
    end
  end
end
