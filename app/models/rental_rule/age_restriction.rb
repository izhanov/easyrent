# frozen_string_literal: true

# == Schema Information
#
# Table name: rental_rule_age_restrictions
#
#  id         :bigint           not null, primary key
#  owner_type :string           not null
#  value      :integer          default(18), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_rental_rule_age_restrictions_on_owner  (owner_type,owner_id) UNIQUE
#
class RentalRule::AgeRestriction < ApplicationRecord
  belongs_to :owner, polymorphic: true

  def model_name_for_form
    ActiveModel::Name.new(self.class, nil, "RentalRule::AgeRestriction")
  end
end
