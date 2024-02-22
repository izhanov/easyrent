class ChangeSlugColumnInAdditionalServices < ActiveRecord::Migration[7.1]
  def up
    change_column :additional_services, :slug, :string, null: true
  end

  def down
    change_column :additional_services, :slug, :string, null: false
  end
end
