require 'active_support/concern'


module VacationEvaluation
  extend ActiveSupport::Concern

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
