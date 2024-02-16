# frozen_string_literal: true

module Validations
  module Office
    module Users
      class Create < Base
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
          required(:phone).filled(:string)
          required(:kind).filled(:string)
        end

        rule(:phone).validate(:phone_format)
        rule(:password_confirmation) do
          key.failure(:not_equal) if value != values[:password]
        end
      end
    end
  end
end
