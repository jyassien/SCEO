class AddFlagsCountToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :flags_count, :integer
  end
end
