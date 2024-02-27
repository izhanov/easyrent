# frozen_string_literal: true

module Validations
  module Office
    module Offers
      class Update < Base
        params do
          required(:title).filled(:string, max_size?: 20)
          required(:prices).filled(:hash)
          required(:mileage_limit_id).filled(:integer)
          optional(:published).value(:bool)
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
