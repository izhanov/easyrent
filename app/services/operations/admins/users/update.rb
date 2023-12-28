# frozen_string_literal: true

module Operations
  module Admins
    module Users
      class Update < Base
        def call(user, params)
          validated_params = yield validate(params)
          user = yield commit(user, validated_params.to_h)
          Success(user)
        end

        private

        def validate(params)
          validation = Validations::Users::Update.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(user, params)
          user.update!(params)
          Success(user)
        end
      end
    end
  end
end
