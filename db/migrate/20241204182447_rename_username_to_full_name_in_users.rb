class RenameUsernameToFullNameInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :username, :full_name
  end
end
