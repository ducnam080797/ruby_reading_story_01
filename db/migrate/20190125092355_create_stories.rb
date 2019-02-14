class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name
      t.string :author_name
      t.string :cover_image
      t.integer :progress
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
