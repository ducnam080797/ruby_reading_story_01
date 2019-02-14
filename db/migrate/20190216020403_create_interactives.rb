class CreateInteractives < ActiveRecord::Migration[5.2]
  def change
    create_table :interactives do |t|
      t.references :user, foreign_key: true
      t.references :story, foreign_key: true
      t.integer :interactive_type

      t.timestamps
    end
  end
end
