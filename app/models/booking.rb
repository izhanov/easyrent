# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id                        :bigint           not null, primary key
#  actual_ends_at            :datetime
#  actual_starts_at          :datetime
#  cash_method_amount        :decimal(10, 2)   default(0.0), not null
#  drop_off_location         :string           not null
#  ends_at                   :datetime         not null
#  halyk_method_amount       :decimal(10, 2)   default(0.0), not null
#  kaspi_method_amount       :decimal(10, 2)   default(0.0), not null
#  number                    :string
#  payment_method            :string
#  pickup_location           :string           not null
#  pledge_amount             :decimal(10, 2)   default(0.0), not null
#  pledge_method             :string
#  prepayment_amount         :decimal(10, 2)   default(0.0), not null
#  prepayment_method         :string
#  self_drop_off             :boolean          default(FALSE)
#  self_pickup               :boolean          default(FALSE)
#  services                  :jsonb
#  starts_at                 :datetime         not null
#  status                    :string           default("initial"), not null
#  with_pledge_amount        :boolean          default(FALSE), not null
#  without_prepayment_amount :boolean
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  car_id                    :bigint           not null
#  client_id                 :bigint           not null
#  offer_id                  :bigint           not null
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

  has_many :comments, as: :commentable, dependent: :destroy
  has_one :contract, dependent: :destroy

  accepts_nested_attributes_for :comments

  audited

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

  PAYMENT_METHODS = %w[kaspi halyk cash mixed]
  PREPAYMENT_METHODS = %w[kaspi halyk cash]
  PLEDGE_METHODS = %w[halyk cash]
  STATUSES = %w[
    initial
    confirmed
    give_out_the_car
    start_the_rent
    end_the_rent
    accept_the_car
    return_the_deposit
    cancelled
    completed
  ]

  def booked_dates
    starts_at.to_date..ends_at.to_date
  end

  def booked_dates_count
    (ends_at.to_date - starts_at.to_date).to_i
  end

  def editable?
    %w[initial confirmed].include?(status)
  end
end
