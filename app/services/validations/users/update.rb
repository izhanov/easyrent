# frozen_string_literal: true

module Validations
  module Users
    class Update < Base
      params do
        required(:first_name).filled(:string)
        required(:last_name).filled(:string)
        required(:kind).filled(:string, included_in?: User::KINDS)
      end
    end
  end
end
