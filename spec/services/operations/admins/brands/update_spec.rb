# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Admins::Brands::Update do
  describe "#call" do
    context "when params invalid" do
      let(:brand) { create(:brand) }

      it "returns failure with errors" do
        result = subject.call(brand, {})

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params valid" do
      let(:brand) { create(:brand) }
      let(:params) { {title: "Robinmobile", synonyms: ["robin", "pussy boy"]} }

      it "updates brand" do
        result = subject.call(brand, params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Brand)
        expect(result.value!.title).to eq("Robinmobile")
        expect(result.value!.synonyms).to eq(["robin", "pussy boy"])
      end
    end
  end
end
