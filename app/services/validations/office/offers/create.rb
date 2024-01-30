# frozen_string_literal: true

module Validations
  module Office
    module Offers
      class Create < Base
        params do
          required(:car_id).filled(:integer)
          required(:title).filled(:string, max_size?: 20)
          required(:prices).filled(:hash)
          required(:mileage_limit_id).filled(:integer)
          required(:published).filled(:bool)
          required(:pledge_amount).filled(:decimal, gt?: 0)
        end

        rule(:prices) do
          unless value.values.all?(&:present?)
            key(offer: :prices).failure(:empty_prices)
          end
        end
      end
    end
  end
end
