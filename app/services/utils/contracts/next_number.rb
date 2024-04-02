# frozen_string_literal: true

module Utils
  module Contracts
    class NextNumber
      def get
        "#{Date.current.year}#{next_number}"
      end

      private

      def next_number
        SecureRandom.hex(2).upcase
      end
    end
  end
end
