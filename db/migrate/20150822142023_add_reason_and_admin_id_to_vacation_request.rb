class AddReasonAndAdminIdToVacationRequest < ActiveRecord::Migration
  def change
    add_column :vacation_requests, :reason, :text, null: false
    execute "UPDATE vacation_requests SET reason='Vacation Has Been Requested'"
    add_column :vacation_requests, :admin_id, :integer
  end
end
