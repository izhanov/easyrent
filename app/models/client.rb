# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id                         :bigint           not null, primary key
#  driver_license_issued_date :date
#  driver_license_number      :string
#  email                      :string
#  first_name                 :string
#  identification_number      :string           not null
#  kind                       :string           default("individual"), not null
#  last_name                  :string
#  passport_number            :string
#  patronymic                 :string
#  phone                      :string           not null
#  residence                  :boolean          default(TRUE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_clients_on_identification_number  (identification_number) UNIQUE
#  index_clients_on_phone                  (phone) UNIQUE
#
class Client < ApplicationRecord
  KINDS = %w[individual legal].freeze
end
