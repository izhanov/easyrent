# frozen_string_literal: true

module Validations
  module Office
    module RentalRules
      module MileageLimits
        class Create < Base
          params do
            required(:owner_id).filled(:integer)
            required(:owner_type).filled(:string)
            required(:title).filled(:string)
            required(:value).filled(:integer, gt?: 0)
            optional(:markup).value(:integer)
            optional(:discount).value(:integer)
          end

          rule(:markup, :discount) do
            if key?(:markup) && key?(:discount)
              if values[:markup].positive? && values[:discount].positive?
                key(:mileage_limit).failure(:only_markup_or_discount)
              end
            end
          end
        end
      end
    end
  end
end
