# frozen_string_literal: true

module Operations
  module Admins
    module Marks
      class Update < Base
        def call(mark, params)
          validated_params = yield validate(params)
          mark = yield commit(mark, validated_params.to_h)
          Success(mark)
        end

        private

        def validate(params)
          validation = Validations::Admins::Marks::Update.new.call(params)
          validation.to_monad
            .or { |result| Failure[:validation_error, result.errors.to_h] }
        end

        def commit(mark, params)
          mark.update!(params)
          Success(mark)
        rescue ActiveRecord::RecordNotUnique
          errors = {title: [I18n.t("dry_validation.errors.rules.mark.title.uniqueness_violation")]}
          Failure[:uniqueness_violation, errors]
        end
      end
    end
  end
end
