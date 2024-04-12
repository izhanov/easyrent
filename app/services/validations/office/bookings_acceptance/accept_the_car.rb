# frozen_string_literal: true

module Validations
  module Office
    module BookingsAcceptance
      class AcceptTheCar < Base
        params do
          required(:actual_ends_at).filled(:time)
          required(:mileage_after_rent).filled(:integer, gt?: 0)
          required(:fuel_level_after_rent).filled(:integer, gt?: 0, lteq?: 100)
          required(:car_wash_amount).filled(:decimal, gteq?: 0)
          required(:fine_amount).filled(:decimal, gteq?: 0)
          required(:return_from_address_amount).filled(:decimal, gteq?: 0)
        end
      end
    end
  end
end
