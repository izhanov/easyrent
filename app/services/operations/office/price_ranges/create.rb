# frozen_string_literal: true

module Operations
  module Office
    module PriceRanges
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          price_range = yield commit(validated_params.to_h)
          Success(price_range)
        end

        private

        def validate(params)
          validation = Validations::Office::PriceRanges::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params)
          price_range = PriceRange.create!(params)
          Success(price_range)
        end
      end
    end
  end
end
