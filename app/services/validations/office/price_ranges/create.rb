# frozen_string_literal: true

module Validations
  module Office
    module PriceRanges
      class Create < Base
        params do
          required(:owner_id).filled(:integer)
          required(:owner_type).filled(:string)
          required(:unit).filled(:string, included_in?: PriceRange::UNITS)
        end
      end
    end
  end
end
