# == Schema Information
#
# Table name: documents
#
#  id                   :bigint           not null, primary key
#  owner_type           :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_template_id :bigint           not null
#  owner_id             :bigint           not null
#
# Indexes
#
#  index_documents_on_document_template_id  (document_template_id)
#  index_documents_on_owner                 (owner_type,owner_id)
#
class Document < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
