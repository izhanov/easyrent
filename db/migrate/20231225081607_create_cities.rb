class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :title, null: false
      t.string :slug

      t.timestamps
    end
  end
end
