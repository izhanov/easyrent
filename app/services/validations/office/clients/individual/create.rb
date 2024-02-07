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
            required(:email).filled(:string)
            required(:driving_license).filled(:string)
            required(:driving_license_issued_date).filled(:date)
            required(:bank_account_number).filled(:string)
            optional(:patronymic).filled(:string)
            optional(:passport_number).value(:string)
          end

          rule(:passport_number) do
            key(:passport_number).failure(:filled?) if key?(:citizen) && values[:citizen] == false
          end

          rule(:bank_account_number).validate(:bank_account_number_format)
        end
      end
    end
  end
end
