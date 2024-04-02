# frozen_string_literal: true

# == Schema Information
#
# Table name: contracts
#
#  id                        :bigint           not null, primary key
#  cost_per_day              :decimal(10, 2)   default(0.0)
#  date                      :date
#  number                    :string
#  permissible_mileage_limit :integer
#  pledge_amount             :decimal(, )
#  pledge_return_date        :date
#  pledge_return_method      :string
#  pledge_return_requisites  :string
#  prepayment_amount         :decimal(, )
#  rental_days               :integer
#  services_total_amount     :decimal(, )
#  total_amount              :decimal(, )
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  booking_id                :bigint           not null
#
# Indexes
#
#  index_contracts_on_booking_id             (booking_id)
#  index_contracts_on_booking_id_and_number  (booking_id,number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_3a318c41a2  (booking_id => bookings.id)
#
class Contract < ApplicationRecord
  belongs_to :booking
  has_many :documents, as: :owner, dependent: :destroy

  audited
end
