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
          params = normalize_pledge_amount(params)
          validation = Validations::Office::Offers::Create.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(params)
          offer = Offer.create!(params)
          Success(offer)
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
