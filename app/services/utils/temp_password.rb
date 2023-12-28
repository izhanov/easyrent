# frozen_string_literal: true

module Utils
  module TempPassword
    extend self

    def generate_numbers(length: 6)
      Array.new(length) { rand(0..9) }.join
    end

    def generate_hex(length: 6)
      SecureRandom.hex(length)
    end
  end
end
