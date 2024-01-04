# frozen_string_literal: true

module Operations
  module Office
    class Base
      include Dry::Monads[:result, :do]
    end
  end
end
