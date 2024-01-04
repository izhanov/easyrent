# frozen_string_literal: true

module Operations
  module Admins
    module Cities
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          city = yield commit(validated_params.to_h)

          Success(city)
        end

        private

        def validate(params)
          validation = Validations::Admins::Cities::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params)
          city = City.create!(params)
          Success(city)
        end
      end
    end
  end
end
