class AddCreatorNameToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :creator_name, :string
  end
end
