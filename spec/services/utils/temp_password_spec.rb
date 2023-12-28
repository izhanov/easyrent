# frozen_string_literal: true

require "rails_helper"

RSpec.describe Utils::TempPassword do
  describe ".generate_numbers" do
    it "returns string with 6 numbers" do
      expect(described_class.generate_numbers).to match(/\A\d{6}\z/)
    end
    context "when length is set" do
      it "returns string with numbers with set length" do
        expect(described_class.generate_numbers(length: 8)).to(
          match(/\A\d{8}\z/)
        )
      end
    end
  end

  describe ".generate_hex" do
    it "returns hex string with 12 bytes" do
      expect(described_class.generate_hex).to match(/\A[0-9a-f]{12}\z/)
    end

    context "when length is set" do
      it "returns hex string with set length 8" do
        expect(described_class.generate_hex(length: 8)).to(
          match(/\A[0-9a-f]{16}\z/)
        )
      end
    end
  end
end
