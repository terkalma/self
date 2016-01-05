class AdjustVacations < ActiveJob::Base

  MAX_VACATION_TRANSFER_LIMIT = 5

  def perform(*args)
    force = !!args[0]
    today = Date.today
    year = today.year
    last_year = year - 1

    # check if we're on the 1st day of the year
    if force || (today.day + today.month == 2)
      User.find_each do |user|
        days_to_transfer = [user.vacation_days_left(last_year), MAX_VACATION_TRANSFER_LIMIT].min

        next unless days_to_transfer > 0

        vl = VacationLimit.find_or_initialize_by(user_id: user.id, year: today.year)

        vl.limit = user.vacation_limit + days_to_transfer
        vl.save
      end
    end
  end
end