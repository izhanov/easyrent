# frozen_string_literal: true

# == Schema Information
#
# Table name: document_templates
#
#  id         :bigint           not null, primary key
#  content    :text
#  context    :string
#  current    :boolean          default(TRUE)
#  kind       :string
#  owner_type :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint
#
# Indexes
#
#  index_document_templates_on_owner  (owner_type,owner_id)
#
class DocumentTemplate < ApplicationRecord
  KINDS = %w[
    contract
    application
  ]

  CONTEXTS = %w[
    contract
    booking
    car
  ]

  scope :current, -> { where(current: true) }
  scope :current_for, ->(context) { current.where(context: context) }
end
