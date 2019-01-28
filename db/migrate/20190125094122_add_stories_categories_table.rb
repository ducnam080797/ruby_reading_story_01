class AddStoriesCategoriesTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :stories, :categories do |t|
      t.index :story_id
      t.index :category_id
    end
  end
end
