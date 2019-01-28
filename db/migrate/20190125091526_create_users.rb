class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :account_name
      t.string :email
      t.string :avatar
      t.boolean :admin

      t.timestamps
    end
  end
end
