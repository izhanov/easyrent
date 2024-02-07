# frozen_string_literal: true

module Operations
  module Office
    module AdditionalServices
      class Destroy < Base
        def call(additional_service)
          yield commit(additional_service)
          Success(additional_service)
        end

        private

        def commit(additional_service)
          additional_service.destroy!
          Success(additional_service)
        end
      end
    end
  end
end
