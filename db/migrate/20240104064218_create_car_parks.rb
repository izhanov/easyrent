class CreateCarParks < ActiveRecord::Migration[7.1]
  def change
    create_table :car_parks do |t|
      t.references :city, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :kind, null: false # Represents business form LLP or IE
      t.string :business_id_number, null: false # Represents IIN or BIN in Republic of Kazakhstan
      t.string :contact_phone
      t.string :bank_name
      t.string :bank_account_number # Represents number of bank account (IBAN)
      t.string :email

      # For IE columns
      t.string :card_id_number # Represents number of ID card for IE
      t.string :privateer_number # Represents number of licnese for IE
      t.date :privateer_date # Represents issue date of license for IE
      t.string :residence_address

      # For LLP columns
      t.string :bank_code # Represents code of bank for LLP (БИК)
      t.string :benificiary_code # Represents code of benificiary for LLP (КБе)
      t.string :legal_address # Represents legal address for LLP
      t.string :service_phone # Represents service phone for LLP

      t.timestamps
    end

    add_index :car_parks, [:city_id, :business_id_number], unique: true
  end
end
