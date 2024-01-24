class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :car, null: false, foreign_key: true
      t.string :title, null: false
      t.jsonb :prices, null: false, default: {}
      t.jsonb :services, null: false, default: {}

      t.timestamps
    end
  end
end
