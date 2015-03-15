class ChangeForeignKeyInEvents < ActiveRecord::Migration
  def change
    rename_column :events, :user_projects_id, :user_project_id
  end
end
