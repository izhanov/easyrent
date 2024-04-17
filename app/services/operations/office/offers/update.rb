# frozen_string_literal: true

module Operations
  module Office
    module Offers
      class Update < Base
        def call(offer, params)
          validated_params = yield validate(params)
          updated_offer = yield commit(offer, validated_params.to_h)
          Success(updated_offer)
        end

        private

        def validate(params)
          params = normalize_prices(params)
          validation = Validations::Office::Offers::Update.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(offer, params)
          offer.update!(params)
          Success(offer.reload)
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
