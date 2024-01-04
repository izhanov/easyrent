# frozen_string_literal: true

module Validations
  module Admins
    module Users
      class Create < Base
        params do
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:email).filled(:string)
          required(:phone).filled(:string)
          required(:kind).filled(:string, included_in?: User::KINDS)
        end

        rule(:phone).validate(:phone_format)
      end
    end
  end
end
