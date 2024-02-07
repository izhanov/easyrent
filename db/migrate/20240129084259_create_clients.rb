class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :phone, null: false, index: { unique: true }
      t.string :identification_number, index: { unique: true }
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :email
      t.string :passport_number # Generally for non-resident clients
      t.string :driving_license
      t.date :driving_license_issued_date
      t.boolean :citizen, default: true
      t.string :kind, default: "individual"
      t.string :bank_account_number # Represents number of bank account (IBAN)

      # for legal entity
      t.string :bank_code # Represents code of bank for legal entity (БИК)
      t.string :legal_address # Represents legal address for legal entity
      t.string :signed_on_basis # Represents signed on basis for legal entity
      t.string :full_name_of_the_head # Represents full name for legal's head

      t.timestamps
    end
  end
end
