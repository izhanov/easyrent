class CreateRentalRuleMileageLimits < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_rule_mileage_limits do |t|
      t.references :owner, polymorphic: true, null: false
      t.string :title, null: false
      t.integer :value, null: false
      t.integer :markup, null: false, default: 0
      t.integer :discount, null: false, default: 0
      t.decimal :over_mileage_price, null: false, default: 0.0, precision: 7, scale: 2
      t.timestamps
    end
  end
end
