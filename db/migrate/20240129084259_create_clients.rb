class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :phone, null: false, index: { unique: true }
      t.string :identification_number, null: false, index: { unique: true }
      t.string :first_name
      t.string :last_name
      t.string :patronymic
      t.string :email
      t.string :passport_number
      t.string :driver_license_number
      t.date :driver_license_issued_date
      t.boolean :residence, default: true
      t.string :kind, default: "individual", null: false

      t.timestamps
    end
  end
end
