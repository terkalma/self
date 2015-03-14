class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, unique: true, null: false, index: true
      t.string :slug, unique: true, null: false, index: true
      t.timestamps null: false
    end
  end
end
