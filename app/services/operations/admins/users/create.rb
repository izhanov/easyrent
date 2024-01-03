# frozen_string_literal: true

module Operations
  module Admins
    module Users
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          user = yield commit(validated_params.to_h)
          invite(user)
          Success(user)
        end

        private

        def validate(params)
          validation = Validations::Admins::Users::Create.new.call(params)
          validation.to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params)
          user = User.create!(
            **params,
            password: generate_temp_password,
            temp_password: generate_temp_password
          )
          Success(user)
        rescue ActiveRecord::RecordNotUnique
          Failure[:uniqueness_violation, {}]
        end

        def generate_temp_password
          Utils::TempPassword.generate_numbers(length: 8)
        end

        def invite(user)
          UserMailer.invite_user(user).deliver_later
        end
      end
    end
  end
end
