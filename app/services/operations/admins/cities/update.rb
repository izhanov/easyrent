# frozen_string_literal: true

module Operations
  module Admins
    module Cities
      class Update < Base
        def call(city, params)
          validated_params = yield validate(params)
          city = yield commit(city, validated_params.to_h)
          Success(city)
        end

        private

        def validate(params)
          validation = Validations::Admins::Cities::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(city, params)
          city.update!(params)
          Success(city)
        end
      end
    end
  end
end
