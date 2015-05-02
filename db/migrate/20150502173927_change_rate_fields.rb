class ChangeRateFields < ActiveRecord::Migration
  def change
    change_column :rates, :available_from, :date
    change_column :rates, :available_until, :date
  end
end
