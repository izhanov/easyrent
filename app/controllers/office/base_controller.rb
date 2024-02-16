# frozen_string_literal: true

module Office
  class BaseController < ApplicationController
    layout "office"

    include Dry::Monads[:result]

    helper FormHelper

    before_action :authenticate_office_user!
    before_action :reset_temp_password?
    around_action :set_time_zone, if: :current_office_user

    private

    def reset_temp_password?
      return unless current_office_user.valid_password?(current_office_user.temp_password)

      redirect_to edit_office_temp_password_path
    end

    def failure_resolver(operation, error_code:)
      path = operation.class.name.underscore.tr("/", ".")
      t("#{path}.errors.#{error_code}")
    end

    def success_resolver(operation = nil, **options)
      if operation
        path = operation.class.name.underscore.tr("/", ".")
        t("#{path}.success")
      else
        t("operations.office.#{options[:path]}.success")
      end
    end

    def set_time_zone(&block)
      Time.use_zone(cookies[:timezone], &block)
    end
  end
end
