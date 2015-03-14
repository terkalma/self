class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :description
      t.integer :user_projects_id, null: false
      t.integer :hours, null: false, default: 0
      t.integer :minutes, null: false, default: 0
      t.timestamps null: false
    end
  end
end
