class AddEventCountersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :created_events_count, :integer, default: 0, null: false
    add_column :users, :registered_events_count, :integer, default: 0, null: false
  end
end
