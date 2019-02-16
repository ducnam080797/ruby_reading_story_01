class CreateLikeds < ActiveRecord::Migration[5.2]
  def change
    create_table :likeds do |t|
      t.references :stories, foreign_key: true
      t.integer :likeable_id
      t.string :likeable_type

      t.timestamps
    end
  end
end
