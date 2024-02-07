class CreateRentalRuleMinimalPeriods < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_rule_minimal_periods do |t|
      t.references :owner, null: false, polymorphic: true
      t.integer :value, null: false, default: 1

      t.timestamps
    end
  end
end
