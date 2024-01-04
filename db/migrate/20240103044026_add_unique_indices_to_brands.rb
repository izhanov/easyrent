class AddUniqueIndicesToBrands < ActiveRecord::Migration[7.1]
  def change
    add_index :brands, :title, unique: true
  end
end
