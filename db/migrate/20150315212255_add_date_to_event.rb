class AddDateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :worked_at, :date, null: false, default: Date.today
  end
end
