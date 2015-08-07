class AddTypeToVacationRequest < ActiveRecord::Migration
  def change
    add_column :vacation_requests, :paid, :boolean, default: true
  end
end
