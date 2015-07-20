class ChangePrecisionTo4 < ActiveRecord::Migration
  def change
    change_column :rates, :hourly_rate, :decimal, precision: 12, scale: 4
    change_column :rates, :hourly_rate_ot, :decimal, precision: 12, scale: 4
    change_column :events, :amount, :decimal, precision: 14, scale: 6, default: 0.0
  end
end
