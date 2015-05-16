class ChangeEventsHourDefault < ActiveRecord::Migration
  def change
    change_column :events, :hours, :integer, null: false, default: 0
  end
end
