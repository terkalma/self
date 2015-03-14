class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.integer :user_id, null: false, index: true
      t.integer :project_id, null: false, index: true
      t.timestamps null: false
    end

    add_index :user_projects, [:user_id, :project_id], unique: true
  end
end
