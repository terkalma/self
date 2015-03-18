class ChangeEvent < ActiveRecord::Migration
  def change
    remove_column :events, :user_project_id
    add_column :events, :user_id, :integer
    add_column :events, :project_id, :integer
    change_column :events, :hours, :integer, null: false, default: 1
  end
end
