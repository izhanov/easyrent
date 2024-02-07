class CreateRentalRuleAgeRestrictions < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_rule_age_restrictions do |t|
      t.references :owner, polymorphic: true, null: false, index: {unique: true}
      t.integer :value, null: false, default: 18

      t.timestamps
    end
  end
end
