class AddRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.decimal :hourly_rate, precision: 10, scale: 2
      t.decimal :hourly_rate_ot, precision: 10, scale: 2
      t.integer :payable_id
      t.string :payable_type
      t.datetime :available_from
      t.datetime :available_until
      t.timestamps
    end
  end
end
