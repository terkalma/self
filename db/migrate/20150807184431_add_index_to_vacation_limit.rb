class AddIndexToVacationLimit < ActiveRecord::Migration
  def change
    add_index :vacation_limits, [:user_id, :year], unique: true
  end
end
