class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.references :booking, null: false, foreign_key: true
      t.date :date
      t.string :number
      t.decimal :total_amount
      t.decimal :pledge_amount
      t.decimal :prepayment_amount
      t.decimal :services_total_amount
      t.integer :rental_days
      t.integer :permissible_mileage_limit
      t.string :pledge_return_method
      t.date :pledge_return_date
      t.string :pledge_return_requisites


      t.timestamps
    end
  end
end
