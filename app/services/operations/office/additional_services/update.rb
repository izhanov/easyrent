# frozen_string_literal: true

module Operations
  module Office
    module AdditionalServices
      class Update < Base
        def call(additional_service, params)
          validated_params = yield validate(params)
          yield commit(additional_service, validated_params.to_h)
          Success(additional_service)
        end

        private

        def validate(params)
          validation = Validations::Office::AdditionalServices::Update.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(additional_service, params)
          additional_service.update!(params)
          Success(additional_service)
        end
      end
    end
  end
end
