class ChangeDefaultValutForVacationRequest < ActiveRecord::Migration[5.0]
  def change
    change_column :vacation_requests, :paid, :boolean, default: false
  end
end
