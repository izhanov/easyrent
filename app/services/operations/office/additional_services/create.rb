# frozen_string_literal: true

module Operations
  module Office
    module AdditionalServices
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          additional_service = yield commit(validated_params.to_h)
          Success(additional_service)
        end

        private

        def validate(params)
          validation = Validations::Office::AdditionalServices::Create.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(params)
          additional_service = AdditionalService.create!(params)
          Success(additional_service)
        end
      end
    end
  end
end
