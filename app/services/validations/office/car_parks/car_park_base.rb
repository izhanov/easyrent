# frozen_string_literal: true

module Validations
  module Office
    module CarParks
      class CarParkBase < Base
        CarParkSchema = Dry::Schema.Params do
          required(:user_id).filled(:integer)
          required(:city_id).filled(:integer)
          required(:title).filled(:string)
          required(:business_id_number).filled(:string)
          required(:kind).filled(:string)
          required(:bank_name).filled(:string)
          required(:bank_account_number).filled(:string)
          optional(:contact_phone).value(:string)
          optional(:email).value(:string)
        end

        params(CarParkSchema)

        rule(:contact_phone).validate(:phone_format)

        rule(:bank_account_number) do
          key.failure(:invalid_format) unless key? && value.match?(/\AKZ[A-Z0-9]{18}\z/)
        end
      end
    end
  end
end
