# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id                          :bigint           not null, primary key
#  bank_account_number         :string
#  bank_code                   :string
#  citizen                     :boolean          default(TRUE)
#  driving_license             :string
#  driving_license_issued_date :date
#  email                       :string
#  full_name_of_the_head       :string
#  identification_number       :string
#  kind                        :string           default("individual")
#  legal_address               :string
#  name                        :string
#  passport_number             :string
#  patronymic                  :string
#  phone                       :string           not null
#  signed_on_basis             :string
#  surname                     :string
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
# Indexes
#
#  index_clients_on_identification_number  (identification_number) UNIQUE
#  index_clients_on_phone                  (phone) UNIQUE
#
class Client < ApplicationRecord
  has_many :bookings, dependent: :destroy

  has_many :clients_in_car_parks, dependent: :destroy
  has_many :car_parks, through: :clients_in_car_parks, dependent: :destroy

  after_commit :update_typesense_index, on: %i[create update]

  KINDS = %w[individual legal].freeze

  include RTypesense

  def update_typesense_index
    Client.typesense_upsert(self) unless Rails.env.test?
  end

  draw_schema do
    string :id, optional: false, locale: I18n.default_locale
    string :name, optional: false, locale: I18n.default_locale
    string :surname, optional: false, locale: I18n.default_locale
    string :patronymic, optional: false, locale: I18n.default_locale
    string :phone, optional: false, infix: true
    string :email, optional: false, infix: true
    string :identification_number, optional: false, infix: false
    string :full_name_of_the_head, optional: true, infix: true

    array_of_string :car_parks do |car_parks|
      string [car_parks, :id], optional: true
    end
  end

  def full_name
    (kind == "individual") ? "#{name} #{surname} #{patronymic}" : full_name_of_the_head
  end

  def surname_with_initials
    (kind == "individual") ? "#{surname} #{name[0]}.#{patronymic[0]}." : full_name_of_the_head
  end
end
