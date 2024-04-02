class AddFileDataFieldToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :file_data, :jsonb
    add_index :documents, :file_data, using: :gin
  end
end
