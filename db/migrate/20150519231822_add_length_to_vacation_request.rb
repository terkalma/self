class AddLengthToVacationRequest < ActiveRecord::Migration
  def change
    add_column :vacation_requests, :length, :integer, default: 0
  end
end
