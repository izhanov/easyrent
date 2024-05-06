# frozen_string_literal: true

module Validations
  module Office
    module CarParks
      module Llp
        class Create < CarParkBase
          params do
            optional(:legal_address).value(:string)
            optional(:bank_code).value(:string, included_in?: Utils::Banks::CODES.values)
            optional(:benificiary_code).value(:string)
            optional(:service_phone).value(:string)
          end

          rule(:service_phone).validate(:phone_format)
        end
      end
    end
  end
end
