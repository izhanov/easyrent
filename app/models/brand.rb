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
class Brand < ApplicationRecord
  has_many :marks, dependent: :destroy
end
