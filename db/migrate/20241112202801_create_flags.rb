class CreateFlags < ActiveRecord::Migration[7.1]
  def change
    create_table :flags do |t|
      t.string :reason
      t.text :description
      t.string :flagged_by
      t.datetime :flagged_at

      t.timestamps
    end
  end
end
