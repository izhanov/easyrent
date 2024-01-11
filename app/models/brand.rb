# frozen_string_literal: true

# == Schema Information
#
# Table name: brands
#
#  id         :bigint           not null, primary key
#  synonyms   :jsonb            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_brands_on_title  (title) UNIQUE
#
class Brand < ApplicationRecord
  has_many :marks, dependent: :destroy

  include RTypesense

  typesense_schema do
    string :id, optional: false
    string :title, optional: false, infix: true
    array_of_string :synonyms, optional: true
  end
end
