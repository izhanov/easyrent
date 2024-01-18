# frozen_string_literal: true

module Operations
  module Office
    module PriceRangeCells
      class Update < Base
        def call(price_range_cell, params)
          validated_params = yield validate(params, price_range: price_range_cell.price_range)
          yield commit(price_range_cell, validated_params.to_h)
          Success(price_range_cell)
        end

        private

        def validate(params, price_range:)
          validation_klass = "Validations::Office::PriceRangeCells::#{price_range.unit.camelize}Unit::Update"
          validation = validation_klass.constantize.new(price_range: price_range).call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(price_range_cell, params)
          price_range_cell.update!(params)
          Success(price_range_cell)
        end
      end
    end
  end
end
