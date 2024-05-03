# == Schema Information
#
# Table name: cars
#
#  id                           :bigint           not null, primary key
#  appearance                   :string           default("clean"), not null
#  color                        :string
#  engine_capacity              :decimal(7, 2)
#  engine_capacity_unit         :string
#  fuel                         :string
#  klass                        :string           not null
#  mileage                      :integer
#  number_of_seats              :integer
#  over_mileage_price           :decimal(10, 2)
#  owner_type                   :string           not null
#  plate_number                 :string           not null
#  status                       :string           default("vacant"), not null
#  tank_volume                  :integer
#  technical_certificate_number :string           not null
#  technical_condition          :string           default("good"), not null
#  transmission                 :string           not null
#  vin_code                     :string           not null
#  year                         :integer          not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  mark_id                      :bigint           not null
#  owner_id                     :bigint           not null
#
# Indexes
#
#  index_cars_on_mark_id                                   (mark_id)
#  index_cars_on_owner                                     (owner_type,owner_id)
#  index_cars_on_owner_id_and_owner_type_and_plate_number  (owner_id,owner_type,plate_number) UNIQUE
#  index_cars_on_owner_id_and_owner_type_and_vin_code      (owner_id,owner_type,vin_code) UNIQUE
#
# Foreign Keys
#
#  fk_rails_77305b2b6f  (mark_id => marks.id)
#
class Car < ApplicationRecord
  belongs_to :mark
  belongs_to :owner, polymorphic: true

  include ArelHelpers::Cars

  has_many :offers, dependent: :destroy
  has_many :bookings, dependent: :destroy, inverse_of: :car
  has_many :photos, dependent: :destroy
  has_many :insurances, class_name: "CarInsurance", dependent: :destroy
  has_one :active_insurance, -> { where("end_at > ?", Date.current) }, class_name: "CarInsurance"
  has_many :car_inspections, dependent: :destroy
  has_many :consumables, dependent: :destroy

  scope :vacant, -> do
    left_joins(:bookings).where.not(
      Booking.arel_table[:starts_at].gteq(Time.current).and(
        Booking.arel_table[:ends_at].lt(Time.current)
      ).and(
        Booking.arel_table[:status].in(
          %w[
            initial
            confirmed
            give_out_the_car
            start_the_rent
            end_the_rent
            accept_the_car
          ]
        )
      )
    ).distinct
  end

  scope :vacant_now_by_id, ->(id) do
    joins(bookings_on_certain_car_id_left_join(id)).where.not(
      Booking.arel_table[:starts_at].gteq(Time.current).and(
        Booking.arel_table[:ends_at].lt(Time.current)
      ).and(
        Booking.arel_table[:status].in(
          %w[
            initial
            confirmed
            give_out_the_car
            start_the_rent
            end_the_rent
            accept_the_car
          ]
        )
      )
    )
  end

  scope :booked_now_by_id, ->(id) do
    joins(bookings_on_certain_car_id_left_join(id)).where(
      Booking.arel_table[:starts_at].gteq(Time.current).and(
        Booking.arel_table[:ends_at].lt(Time.current)
      ).and(
        Booking.arel_table[:status].in(
          %w[
            initial
            confirmed
          ]
        )
      )
    )
  end

  scope :booked, -> do
    left_joins(:bookings).where(
      Booking.arel_table[:starts_at].gteq(Time.current).and(
        Booking.arel_table[:ends_at].lt(Time.current)
      ).and(
        Booking.arel_table[:status].in(
          %w[
            initial
            confirmed
          ]
        )
      )
    ).distinct
  end

  scope :occupied_now_by_id, ->(id) do
    joins(bookings_on_certain_car_id_left_join(id)).where(
      Booking.arel_table[:starts_at].lt(Time.current).and(
        Booking.arel_table[:ends_at].gt(Time.current)
      ).and(
        Booking.arel_table[:status].in(
          %w[
            give_out_the_car
            start_the_rent
            end_the_rent
            accept_the_car
          ]
        )
      )
    )
  end

  scope :occupied, -> do
    left_joins(:bookings).where(
      Booking.arel_table[:starts_at].lt(Time.current).and(
        Booking.arel_table[:ends_at].gt(Time.current)
      ).and(
        Booking.arel_table[:status].in(
          %w[
            give_out_the_car
            start_the_rent
            end_the_rent
            accept_the_car
          ]
        )
      )
    ).distinct
  end

  scope :in_repair, -> { where(technical_condition: "under_repair") }
  scope :need_repair, -> { where(technical_condition: "need_repair") }

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :insurances, allow_destroy: true
  accepts_nested_attributes_for :car_inspections, allow_destroy: true

  after_commit :update_typesense_index, on: %i[create update]

  audited

  # Requirements:
  # Typesense server running on localhost:8108
  # gem 'typesense'
  include RTypesense

  def update_typesense_index
    Car.typesense_upsert(self) unless Rails.env.test?
  end

  draw_schema do
    string :id, optional: false
    string :vin_code, optional: false, infix: true
    string :year, optional: true
    string :color, optional: true, infix: true, facet: true
    string :status, optional: false, infix: true
    string :plate_number, optional: false, infix: true
    string :klass, optional: true, infix: true, facet: true
    object :mark, optional: false do |mark|
      string [mark, :title], optional: false
      array_of_string [mark, :synonyms], optional: true
      object [mark, :brand], optional: false do |brand|
        string [brand, :title], optional: false
        array_of_string [brand, :synonyms], optional: true
      end
    end

    object :owner, optional: false do |owner|
      string [owner, :id], optional: false
      string [owner, :city_id], optional: false
    end
  end

  FUEL_TYPES = %w[petrol diesel gas electric].freeze
  KLASS_TYPES = %w[economy comfort business premium ultima].freeze
  TRANSMISSION_TYPES = %w[manual automatic robotic_gearbox cvt].freeze
  ENGINE_CAPACITY_UNITS = %w[cm3 l].freeze
  APPEARANCE_TYPES = %w[clean dirty].freeze
  TECHNICAL_CONDITION_TYPES = %w[good need_repair under_repair].freeze

  def vacant?
    Car.vacant_now_by_id(id).present?
  end

  def booked?
    Car.booked_now_by_id(id).present?
  end

  def occupied?
    Car.occupied_now_by_id(id).present?
  end

  def current_status
    if vacant?
      "vacant"
    elsif booked?
      "booked"
    elsif occupied?
      "occupied"
    end
  end

  def mark_title
    "#{mark.brand.title} #{mark.title}"
  end

  def offer_price(plan, days_count)
    offer = offers.find_by(title: plan, published: true)
    return if offer.blank?

    price_for_rent_period(offer, days_count).to_fs(:currency, format: "%n", precision: 0)
  end

  def string_range_to_range(string_range)
    Range.new(*string_range.split("..").map(&:to_i))
  end

  def price_string_to_decimal(price_string)
    BigDecimal(price_string.to_s.gsub(/[^0-9,.]/, ""))
  end

  def price_for_rent_period(offer, days_count)
    needed_range = offer.prices.keys.detect { |range| string_range_to_range(range).cover?(days_count) }

    if needed_range
      price_string_to_decimal(offer.prices[needed_range])
    else
      nearest_range = prices.keys.min_by { |range| (range.max - days_count).abs }
      price_string_to_decimal(prices[nearest_range])
    end
  end
end
