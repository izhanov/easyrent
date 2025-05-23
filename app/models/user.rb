# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  kind                   :string           default("s"), not null
#  last_name              :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  phone                  :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  temp_password          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable
  )

  KINDS = %w[s m l xl].freeze

  # Associations
  has_many :car_parks, dependent: :destroy
  has_many :cars, through: :car_parks, dependent: :destroy
  has_many :offers, through: :cars, dependent: :destroy
  has_many :bookings, through: :cars, dependent: :destroy
  has_many :clients_in_users_companies, dependent: :destroy
  has_many :clients, through: :clients_in_users_companies, dependent: :destroy
  has_many :document_templates, through: :car_parks, dependent: :destroy
  has_many :documents, through: :bookings

  def full_name
    "#{first_name} #{last_name}"
  end
end
