# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Admins::Cities::Update do
  describe "#call" do
    let(:city) { create(:city) }
    context "when params invalid" do
      it "returns failure with errors" do
        result = subject.call(city, {slug: ""})
        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params valid" do
      let(:params) { {title: "Metropolis", slug: "metropolis"} }
      it "updates city" do
        result = subject.call(city, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(City)
        expect(result.value!.title).to eq("Metropolis")
      end
    end
  end
end
