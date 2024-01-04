# frozen_string_literal: true

module Operations
  module Admins
    module Brands
      class Update < Base
        def call(brand, params)
          validated_params = yield validate(params)
          yield commit(brand, validated_params.to_h)
          Success(brand)
        end

        private

        def validate(params)
          validation = Validations::Admins::Brands::Update.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(brand, params)
          brand.update!(params)
          Success(brand)
        end
      end
    end
  end
end
