class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :user_type
      t.string :college_name

      t.timestamps
    end
  end
end
