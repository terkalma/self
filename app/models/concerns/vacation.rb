require 'active_support/concern'

module Vacation
  extend ActiveSupport::Concern

  included do
    has_many :vacation_requests, dependent: :destroy
    has_many :vacation_limits, dependent: :destroy
  end

  class_methods do
    def vacationing
      self.where id: VacationRequest.active.pluck(:user_id).uniq
    end

    def vacation_alert_at(date, key: :email)
      Rails.cache.fetch "#{date}-#{VacationRequest.at(date).last.try(:updated_at)}" do
        join_clause = <<-SQL
          LEFT JOIN vacation_requests as vr ON (vr.user_id = users.id
          AND vr.vacation_from <= '#{date}'
          AND vr.vacation_to >= '#{date}'
          AND vr.status <> #{VacationRequest.statuses[:declined]})
        SQL

        select_clause = <<-SQL
          array_to_string(array_agg(distinct vr.status), ' ') as vacation_alert, users.*
        SQL

        joins(join_clause).group('users.id').select(select_clause).map do |u|
            [(u.send(key) || 'default'), u.vacation_alert]
        end
      end
    end

    def vacation_alert(from:, to:, key: :email)
      mapping = {}

      (from..to).each do |date|
        vacation_alert_at(date, key: key).reduce(mapping) do |mapping, user|
          mapping[user[0]] ||= {}
          mapping[user[0]][date.to_s] = user[1]
          mapping
        end
      end

      mapping
    end
  end

  def vacation_limit
    vacation_limit_at Date.today.year
  end

  def vacation_limit_at(year)
    vacation_limits.at(year).first.try(:limit) || self['vacation_limit']
  end

  def on_vacation?
    vacation_requests.active.count > 0
  end

  def vacation_days_left(year=Date.today.year)
    vacation_limit_at(year) - days_on_vacation(year)
  end

  def vacation_status(date=Date.today)
    return 'active' if vacation_requests.active_at(date).count > 0
    return 'peding' if vacation_requests.pending_at(date).count > 0

    'working'
  end

  #
  # Only counting payed days.
  #
  def days_on_vacation_this_year
    days_on_vacation Date.today.year
  end

  def days_on_vacation(year)
    date = Date.new(year, 1, 1).beginning_of_day

    from = date.beginning_of_year
    to = date.end_of_year

    vacation_requests.approved.paid.where('vacation_from >= ?', from).where('vacation_to <= ?', to).pluck(:length).sum
  end
end