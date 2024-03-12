# frozen_string_literal: true

module Office
  module AJAX
    class BaseController < ActionController::API
      include Dry::Monads[:result]
    end
  end
end
