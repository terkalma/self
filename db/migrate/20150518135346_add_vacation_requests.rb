class AddVacationRequests < ActiveRecord::Migration
  def change
    create_table :vacation_requests do |t|
      t.date :vacation_from, null: false
      t.date :vacation_to, null: false
      t.integer :user_id
      t.column :status, :integer, default: 0
      t.timestamps
    end
  end
end
