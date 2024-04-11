# frozen_string_literal: true

module Validations
  module Office
    module BookingsGiveOuts
      class GiveOutTheCar < Base
        params do
          required(:actual_starts_at).filled(:time)
          required(:actual_ends_at).filled(:time)
          required(:mileage_before_rent).filled(:integer, gt?: 0)
          required(:fuel_level_before_rent).filled(:integer, gt?: 0, lteq?: 100)
          required(:appearance_before_rent).filled(:string)
          required(:technical_condition_before_rent).filled(:string)
        end
      end
    end
  end
end
