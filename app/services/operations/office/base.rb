# frozen_string_literal: true

module Operations
  module Office
    class Base
      include Dry::Monads[:result, :do]

      private

      def audit_as_user(user, &block)
        Audited.audit_class.as_user(user, &block)
      end
    end
  end
end
