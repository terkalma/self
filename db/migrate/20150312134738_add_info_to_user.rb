class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :first_name, :string, null: false, default: 'N/A'
    add_column :users, :last_name, :string, null: false, default: 'N/A'
  end
end
