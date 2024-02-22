# frozen_string_literal: true

module Validations
  module Office
    module Clients
      module Legal
        class Update < Base
          params do
            required(:name).filled(:string)
            required(:phone).filled(:string)
            required(:email).filled(:string)
            required(:full_name_of_the_head).filled(:string)
            required(:legal_address).filled(:string)
            required(:bank_code).filled(:string)
            required(:bank_account_number).filled(:string)
            required(:signed_on_basis).filled(:string)
          end
        end
      end
    end
  end
end
