# frozen_string_literal: true

module Operations
  module Admins
    module Brands
      class Create < Base
        def call(params)
          validated_params = yield validate(params)
          brand = yield commit(validated_params.to_h)
          Success(brand)
        end

        private

        def validate(params)
          validation = Validations::Admins::Brands::Create.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(params)
          brand = Brand.create!(params)
          Success(brand)
        rescue ActiveRecord::RecordNotUnique => e
          Failure[:uniqueness_violation, {}]
        end
      end
    end
  end
end
