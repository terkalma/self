class AddIndexToRates < ActiveRecord::Migration
  def change
    add_index :rates, :payable_id
  end
end
