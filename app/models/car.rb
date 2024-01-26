# == Schema Information
#
# Table name: cars
#
#  id                           :bigint           not null, primary key
#  color                        :string
#  engine_capacity              :integer
#  engine_capacity_unit         :string
#  fuel                         :string
#  klass                        :string           not null
#  mileage                      :integer
#  number_of_seats              :integer
#  owner_type                   :string           not null
#  plate_number                 :string           not null
#  status                       :string           default("vacant"), not null
#  tank_volume                  :integer
#  technical_certificate_number :string           not null
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

  has_many :offers, dependent: :destroy

  def mark_title
    "#{mark.brand.title} #{mark.title}"
  end

  include AASM

  aasm column: :status do
    state :vacant, initial: true
    state :booked
    state :rented
    state :repair_needed
    state :in_service

    event :book do
      transitions from: :vacant, to: :booked
    end

    event :rent do
      transitions from: :booked, to: :rented
    end

    event :survey do
      transitions from: :rented, to: :repair_needed
    end

    event :repair do
      transitions from: :repair_needed, to: :in_service
    end
  end

  # Requirements:
  # Typesense server running on localhost:8108
  # gem 'typesense'
  include RTypesense

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
  end

  FUEL_TYPES = %w[petrol diesel gas electric].freeze
  KLASS_TYPES = %w[economy comfort business premium ultima].freeze
  TRANSMISSION_TYPES = %w[manual automatic robotic_gearbox cvt].freeze
  ENGINE_CAPACITY_UNITS = %w[cm3 l].freeze
end
