class AddStatusToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status, :string, null: false, default: 'submitted'
  end
end
