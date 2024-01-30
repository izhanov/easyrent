# frozen_string_literal: true

module Operations
  module Office
    module PriceRanges
      class Update < Base
        def call(price_range, params)
          validated_params = yield validate(params)
          updated_price_range = yield commit(price_range, validated_params.to_h)
          Success(updated_price_range)
        end

        private

        def validate(params)
          validation = Validations::Office::PriceRanges::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(price_range, params)
          price_range.update!(params)
          Success(price_range.reload)
        end
      end
    end
  end
end
