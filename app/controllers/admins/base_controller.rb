# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    layout "admins"

    include Dry::Monads[:result]

    helper FormHelper

    before_action :authenticate_admin!

    private

    def failure_resolver(operation, error_code:)
      path = operation.class.name.underscore.tr("/", ".")
      t("#{path}.errors.#{error_code}")
    end

    def success_resolver(operation = nil, **options)
      if operation
        path = operation.class.name.underscore.tr("/", ".")
        t("#{path}.success")
      else
        t("operations.admins.#{options[:path]}.success")
      end
    end
  end
end
