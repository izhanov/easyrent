# frozen_string_literal: true

# == Schema Information
#
# Table name: additional_services
#
#  id         :bigint           not null, primary key
#  owner_type :string           not null
#  price      :decimal(10, 2)   not null
#  slug       :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_additional_services_on_owner  (owner_type,owner_id)
#
class AdditionalService < ApplicationRecord
  belongs_to :owner, polymorphic: true

  SERVICES = %w[
    gps_navigator
    child_seat
    booster
    ski_and_snowboard_rack
    wifi_router
    tourist_equipment
    delivery_to_the_address
    return_to_the_address
    phone_holder
    usb_for_phone
    additional_driver
  ]

  def title_ru
    I18n.t("activerecord.attributes.additional_service.services.#{title}")
  end
end
