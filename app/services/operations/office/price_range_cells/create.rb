# frozen_string_literal: true

module Operations
  module Office
    module PriceRangeCells
      class Create < Base
        def call(params)
          price_range = yield find_price_range(params[:price_range_id])
          validated_params = yield validate(params, price_range: price_range)
          price_range_cell = yield commit(validated_params.to_h)
          Success(price_range_cell)
        end

        private

        def find_price_range(price_range_id)
          price_range = PriceRange.find(price_range_id)
          Success(price_range)
        rescue ActiveRecord::RecordNotFound
          Failure[:base_error, {price_range_id: ["Price range not found"]}]
        end

        def validate(params, price_range:)
          validation_klass = "Validations::Office::PriceRangeCells::#{price_range.unit.camelize}Unit::Create"
          validation = validation_klass.constantize.new(price_range: price_range).call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(params)
          price_range_cell = PriceRangeCell.create!(params)
          Success(price_range_cell)
        end
      end
    end
  end
end
