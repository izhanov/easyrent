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
  include ArelHelpers::Bookings

  belongs_to :car, inverse_of: :bookings
  belongs_to :client, inverse_of: :bookings
  belongs_to :offer, inverse_of: :booking

  has_many :comments, as: :commentable, dependent: :destroy
  has_one :contract, dependent: :destroy
  has_one :give_out_appendix, class_name: "BookingGiveOutAppendix", dependent: :destroy
  has_one :acceptance_appendix, class_name: "BookingAcceptanceAppendix", dependent: :destroy

  has_many :documents, through: :contract

  after_commit :update_typesense_index, on: %i[create update]

  accepts_nested_attributes_for :comments

  scope :by_status, ->(status) { where(status: status) }

  scope :nearest_to_give_out, -> do
    where(arel_table[:status].eq("give_out_the_car")).order(
      by_nearest_to_now_order(arel_table[:starts_at]) # See app/models/concerns/arel_helpers/bookings.rb
    )
  end

  scope :nearest_to_accept, -> do
    where(arel_table[:status].eq("accept_the_car").or(arel_table[:status].eq("end_the_rent")))
      .order(
        by_nearest_to_now_order(arel_table[:ends_at]) # See app/models/concerns/arel_helpers/bookings.rb
      )
  end

  audited

  include RTypesense

  def update_typesense_index
    Booking.typesense_upsert(self) unless Rails.env.test?
  end

  draw_schema do
    string :id, optional: false
    string :number, optional: false
    int32 :starts_at, optional: false
    int32 :ends_at, optional: false
    int32 :actual_starts_at, optional: true
    int32 :actual_ends_at, optional: true
    object :car, optional: false do |car|
      string [car, :id], optional: false
      string [car, :plate_number], optional: false

      object [car, :owner], optional: false do |owner|
        string [owner, :id], optional: false
        string [owner, :title], optional: false
      end
    end

    object :offer do |offer|
      string [offer, :id], optional: false
      string [offer, :title], optional: false
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

  def manager_full_name
    "Зейнешев Диас"
  end
end
