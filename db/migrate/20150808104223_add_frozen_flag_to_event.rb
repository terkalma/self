class AddFrozenFlagToEvent < ActiveRecord::Migration
  def change
    add_column :events, :gefroren, :boolean, default: false
  end
end
