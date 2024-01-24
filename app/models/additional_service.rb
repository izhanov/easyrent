# frozen_string_literal: true

# == Schema Information
#
# Table name: additional_services
#
#  id         :bigint           not null, primary key
#  owner_type :string           not null
#  price      :decimal(10, 2)   not null
#  slug       :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_additional_services_on_owner  (owner_type,owner_id)
#
class AdditionalService < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
