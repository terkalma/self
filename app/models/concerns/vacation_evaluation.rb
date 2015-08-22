require 'active_support/concern'


module VacationEvaluation
  extend ActiveSupport::Concern

  def approved_with_event_creation!
    return if approved?

    transaction do
      approved_without_event_creation!
      paid? && (vacation_from..vacation_to).each do |worked_at|

        if (1..5).include? worked_at.wday
          Event.create(
              worked_at: worked_at,
              user_id: user_id,
              hours: 8,
              description: "#{human_type} vacation",
              gefroren: true
          )
        end
      end
    end
  end

  def approved_by!(admin)
    evaluate_by!(admin) { approved! }
  end

  def declined_by!(admin)
    evaluate_by!(admin) { declined! }
  end

  def evaluate_by!(admin)
    return self unless admin.admin?

    transaction do
      self.admin = admin
      yield
    end

    self
  end

  def unpaid?
    !paid?
  end
end
