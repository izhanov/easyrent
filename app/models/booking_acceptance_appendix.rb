# frozen_string_literal: true

# == Schema Information
#
# Table name: booking_acceptance_appendixes
#
#  id                         :bigint           not null, primary key
#  car_wash_amount            :decimal(10, 2)   default(0.0), not null
#  fine_amount                :decimal(10, 2)   default(0.0), not null
#  fuel_level_after_rent      :integer
#  mileage_after_rent         :integer
#  return_from_address_amount :decimal(10, 2)   default(0.0), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  booking_id                 :bigint           not null
#
# Indexes
#
#  index_booking_acceptance_appendixes_on_booking_id  (booking_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_e6b4fcacef  (booking_id => bookings.id)
#
class BookingAcceptanceAppendix < ApplicationRecord
  belongs_to :booking
end
