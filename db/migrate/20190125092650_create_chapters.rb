class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :content
      t.string :image
      t.references :story, foreign_key: true

      t.timestamps
    end
  end
end
