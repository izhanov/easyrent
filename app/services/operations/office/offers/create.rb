# frozen_string_literal: true

module Operations
  module Office
    module Offers
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          offer = yield commit(validated_params.to_h)
          Success(offer)
        end

        private

        def validate(params)
          validation = Validations::Office::Offers::Create.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(params)
          params = normalize_prices(params)
          offer = Offer.create!(params)
          Success(offer)
        end

        def normalize_prices(params)
          if params.key?(:prices)
            params[:prices] = params[:prices].each_with_object({}) do |(range, price), prices|
              prices[range] = BigDecimal(price.gsub(/[^0-9,.]/, "")).to_f
            end
          end
          params
        end
      end
    end
  end
end
