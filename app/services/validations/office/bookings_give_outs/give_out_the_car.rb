# frozen_string_literal: true

module Validations
  module Office
    module BookingsGiveOuts
      class GiveOutTheCar < Base
        params do
          required(:actual_starts_at).filled(:time)
          required(:mileage_before_rent).filled(:integer, gt?: 0)
        end
      end
    end
  end
end
