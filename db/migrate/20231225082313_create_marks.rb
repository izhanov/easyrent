class CreateMarks < ActiveRecord::Migration[7.1]
  def change
    create_table :marks do |t|
      t.references :brand, null: false, foreign_key: true
      t.string :title, null: false
      t.string :body, null: false
      t.jsonb :synonyms, null: false, default: []

      t.timestamps
    end
  end
end
