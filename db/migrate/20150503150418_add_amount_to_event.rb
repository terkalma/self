class AddAmountToEvent < ActiveRecord::Migration
  def change
    add_column :events, :amount, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :events, :ot, :boolean, default: false
  end
end
