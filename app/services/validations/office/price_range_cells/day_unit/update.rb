# frozen_string_literal: true

module Validations
  module Office
    module PriceRangeCells
      module DayUnit
        class Update < Base
          option :price_range

          params do
            required(:from).filled(:integer)
            required(:to).filled(:integer)
          end
        end
      end
    end
  end
end
