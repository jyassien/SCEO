class AddRegisteredUsersCountToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :registered_users_count, :integer, default: 0, null: false
  end
end
