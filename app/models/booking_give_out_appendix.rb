# == Schema Information
#
# Table name: booking_give_out_appendixes
#
#  id                              :bigint           not null, primary key
#  appearance_before_rent          :string
#  fuel_level_before_rent          :integer
#  mileage_before_rent             :integer
#  technical_condition_before_rent :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  booking_id                      :bigint           not null
#
# Indexes
#
#  index_booking_give_out_appendixes_on_booking_id  (booking_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_13838714b2  (booking_id => bookings.id)
#
class BookingGiveOutAppendix < ApplicationRecord
  belongs_to :booking
end
