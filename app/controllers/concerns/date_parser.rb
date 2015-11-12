require 'active_support/concern'

module DateParser
  extend ActiveSupport::Concern

  included do
    attr_reader :date, :from_date, :to_date
    before_filter :parse_dates
    before_filter :date

    helper_method :date, :from_date, :to_date
  end

  def parse_dates
    today = Date.today

    @from_date = Date.strptime(params[:from_date]) rescue today.beginning_of_month
    @to_date = Date.strptime(params[:to_date]) rescue today.end_of_month
  end

  def date
    @date = Date.strptime(params[:date]) rescue Date.today
  end
end