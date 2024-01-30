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
          params = normalize_pledge_amount(params)
          validation = Validations::Office::Offers::Update.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(offer, params)
          offer.update!(params)
          Success(offer.reload)
        end

        def normalize_pledge_amount(params)
          if params.key?(:pledge_amount)
            params[:pledge_amount] = params[:pledge_amount].to_s.gsub(/[^0-9]/, "").to_f
          end
          params
        end
      end
    end
  end
end
