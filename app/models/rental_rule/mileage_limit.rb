# frozen_string_literal: true

# == Schema Information
#
# Table name: rental_rule_mileage_limits
#
#  id                 :bigint           not null, primary key
#  discount           :integer          default(0), not null
#  markup             :integer          default(0), not null
#  over_mileage_price :decimal(7, 2)    default(0.0), not null
#  owner_type         :string           not null
#  title              :string           not null
#  value              :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  owner_id           :bigint           not null
#
# Indexes
#
#  index_rental_rule_mileage_limits_on_owner  (owner_type,owner_id)
#
class RentalRule::MileageLimit < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
