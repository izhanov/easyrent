# frozen_string_literal: true

# == Schema Information
#
# Table name: rental_rule_driving_experiences
#
#  id         :bigint           not null, primary key
#  owner_type :string           not null
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_rental_rule_driving_experiences_on_owner  (owner_type,owner_id) UNIQUE
#
class RentalRule::DrivingExperience < ApplicationRecord
  belongs_to :owner, polymorphic: true
end
