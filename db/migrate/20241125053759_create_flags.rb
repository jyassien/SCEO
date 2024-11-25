class CreateFlags < ActiveRecord::Migration[7.1]
  def change
    create_table :flags do |t|
      t.string :reason
      t.text :description
      t.datetime :flagged_at
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
