class ChangePrecisionTo3 < ActiveRecord::Migration
  def change
    change_column :rates, :hourly_rate, :decimal, precision: 10, scale: 3
    change_column :rates, :hourly_rate_ot, :decimal, precision: 10, scale: 3
    change_column :events, :amount, :decimal, precision: 10, scale: 3, default: 0.0
  end
end
