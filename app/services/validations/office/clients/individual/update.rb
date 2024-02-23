# frozen_string_literal: true

module Validations
  module Office
    module Clients
      module Individual
        class Update < Base
          params do
            required(:name).filled(:string)
            required(:phone).filled(:string)
            required(:surname).filled(:string)
            required(:citizen).filled(:bool)
            required(:email).filled(:string)
            required(:driving_license).filled(:string)
            required(:driving_license_issued_date).filled(:date)
            optional(:bank_account_number).value(:string)
            optional(:patronymic).value(:string)
            optional(:passport_number).value(:string)
          end

          rule(:passport_number) do
            key(:passport_number).failure(:filled?) if key?(:citizen) && values[:citizen] == false
          end

          rule(:bank_account_number) do
            key.failure(:invalid_format) unless value.present? && value.match?(/\AKZ[A-Z0-9]{18}\z/)
          end
        end
      end
    end
  end
end
