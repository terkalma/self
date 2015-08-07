class CreateVacationLimits < ActiveRecord::Migration
  def change
    create_table :vacation_limits do |t|
      t.integer :year, null: false
      t.integer :limit, null: false
      t.integer :user_id, null: false, index: true
      t.timestamps null: false
    end
  end
end
