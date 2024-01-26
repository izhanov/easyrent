# frozen_string_literal: true

# == Schema Information
#
# Table name: rental_rule_minimal_periods
#
#  id         :bigint           not null, primary key
#  owner_type :string           not null
#  value      :integer          default(1), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_rental_rule_minimal_periods_on_owner  (owner_type,owner_id)
#
class RentalRule::MinimalPeriod < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
