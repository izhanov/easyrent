# frozen_string_literal: true

module Operations
  module Office
    module Users
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          user = yield commit(validated_params.to_h)
          Success(user)
        end

        private

        def validate(params)
          validation = Validations::Office::Users::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params)
          user = User.create!(params)
          Success(user)
        end
      end
    end
  end
end
