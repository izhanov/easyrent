# frozen_string_literal: true

module Validations
  module Office
    module Clients
      module Individual
        class Create < Base
          params do
            required(:name).filled(:string)
            required(:surname).filled(:string)
            required(:identification_number).filled(:string)
            required(:phone).filled(:string)
            required(:kind).filled(:string)
            required(:citizen).filled(:bool)
            required(:driving_license).filled(:string)
            required(:driving_license_issued_date).filled(:date)
            optional(:email).value(:string)
            optional(:bank_account_number).value(:string)
            optional(:patronymic).value(:string)
            optional(:passport_number).value(:string)
          end

          rule(:passport_number) do
            key(:passport_number).failure(:filled?) if key?(:citizen) && values[:citizen] == false
          end

          rule(:bank_account_number) do
            if value.present?
              key.failure(:invalid_format) unless value.match?(/\AKZ[A-Z0-9]{18}\z/)
            end
          end
        end
      end
    end
  end
end
