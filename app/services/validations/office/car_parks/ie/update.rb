# frozen_string_literal: true

module Validations
  module Office
    module CarParks
      module Ie
        class Update < CarParkBase
          params do
            optional(:card_id_number).value(:string, max_size?: 9)
            optional(:privateer_number).value(:string)
            optional(:privateer_date).value(:date)
            optional(:residence_address).value(:string)
          end
        end
      end
    end
  end
end
