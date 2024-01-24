class CreateAdditionalServices < ActiveRecord::Migration[7.1]
  def change
    create_table :additional_services do |t|
      t.references :owner, polymorphic: true, null: false
      t.string :title, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :slug, null: false

      t.timestamps
    end
  end
end
