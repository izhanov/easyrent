class CreateClientsInUsersCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :clients_in_users_companies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
