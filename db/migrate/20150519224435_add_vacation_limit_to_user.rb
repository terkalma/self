class AddVacationLimitToUser < ActiveRecord::Migration
  def up
    add_column :users, :vacation_limit, :integer, null: false, default: 10

    execute <<-SQL
      UPDATE users SET vacation_limit = 10
    SQL
  end

  def down
    remove_column :users, :vacation_limit
  end
end
