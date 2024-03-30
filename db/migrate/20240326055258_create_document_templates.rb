class CreateDocumentTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :document_templates do |t|
      t.references :owner, polymorphic: true
      t.string :title
      t.string :context
      t.text :content
      t.string :kind
      t.boolean :current, default: true

      t.timestamps
    end
  end
end
