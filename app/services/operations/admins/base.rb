# frozen_string_literal: true

module Operations
  module Admins
    class Base
      include Dry::Monads[:result, :do]
    end
  end
end
