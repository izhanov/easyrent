# frozen_string_literal: true
require "rails_helper"

RSpec.describe Operations::Admins::Cities::Create do
  describe "#call" do
    context "when params invalid" do
      it "returns failure with errors" do
        result = subject.call({})

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params valid" do
      let(:params) { {title: "Test", slug: "test"} }
      it "creates city" do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(City)
      end
    end
  end
end
