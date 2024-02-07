class CreateRentalRuleDrivingExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :rental_rule_driving_experiences do |t|
      t.references :owner, polymorphic: true, null: false, index: {unique: true}
      t.integer :value, null: false

      t.timestamps
    end
  end
end
