# frozen_string_literal: true

module Validations
  module Office
    module PriceRanges
      class Update < Base
        params do
          required(:unit).filled(:string, included_in?: PriceRange::UNITS)
        end
      end
    end
  end
end
