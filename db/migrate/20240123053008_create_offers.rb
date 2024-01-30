class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.references :car, null: false, foreign_key: true
      t.string :title, null: false
      t.jsonb :prices, null: false, default: {}
      t.integer :mileage_limit_id, null: false
      t.decimal :pledge_amount, null: false, precision: 10, scale: 2
      t.boolean :published, null: false, default: false

      t.timestamps
    end
  end
end
