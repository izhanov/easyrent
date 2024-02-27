# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id                 :bigint           not null, primary key
#  actual_ends_at     :datetime
#  actual_starts_at   :datetime
#  drop_off_location  :string           not null
#  ends_at            :datetime         not null
#  number             :string
#  payment_method     :string
#  pickup_location    :string           not null
#  pledge_amount      :decimal(10, 2)   default(0.0), not null
#  self_drop_off      :boolean          default(FALSE)
#  self_pickup        :boolean          default(FALSE)
#  services           :jsonb
#  starts_at          :datetime         not null
#  status             :string           default("new"), not null
#  with_pledge_amount :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  car_id             :bigint           not null
#  client_id          :bigint           not null
#  offer_id           :bigint           not null
#
# Indexes
#
#  index_bookings_on_car_id     (car_id)
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_ends_at    (ends_at) USING brin
#  index_bookings_on_offer_id   (offer_id)
#  index_bookings_on_starts_at  (starts_at) USING brin
#
# Foreign Keys
#
#  fk_rails_2c503ea743  (client_id => clients.id)
#  fk_rails_5e4e81d007  (car_id => cars.id)
#  fk_rails_9c126c1dd5  (offer_id => offers.id)
#
class Booking < ApplicationRecord
  belongs_to :car, inverse_of: :bookings
  belongs_to :client, inverse_of: :bookings
  belongs_to :offer, inverse_of: :booking

  include RTypesense

  draw_schema do
    int32 :start_datetime, optional: false
    int32 :end_datetime, optional: false
    int32 :actual_start_datetime, optional: true
    int32 :actual_end_datetime, optional: true
    object :car, optional: false do |car|
      string [car, :id], optional: false
    end

    object :offer do |offer|
      string [offer, :id], optional: false
      object [offer, :title], optional: false
    end
  end

  PAYMENT_METHODS = %w[cash cashless]
  STATUSES = %w[
    new
    confirmed
    payment_accepted
    give_out_the_car
    car_in_rent
    accept_the_car
    return_the_deposit
    canceled
    finished
  ]

  def booked_dates
    starts_at.to_date..ends_at.to_date
  end

  def booked_dates_count
    (ends_at.to_date - starts_at.to_date).to_i
  end
end
