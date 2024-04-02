class AddKindColumnToAdditionalServices < ActiveRecord::Migration[7.1]
  def change
    add_column :additional_services, :kind, :string
  end
end
