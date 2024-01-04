# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Admins::Brands::Create do
  describe "#call" do
    context "when params invalid" do
      it "returns failure with errors" do
        result = subject.call({})

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params valid" do
      let(:params) { {title: "Batcar", synonyms: ["batmobile", "pussy wagon"]} }
      it "creates brand" do
        result = subject.call(params)
        expect(result).to be_a(Dry::Monads::Success)
        expect(result.value!).to be_a(Brand)
        expect(result.value!.title).to eq("Batcar")
        expect(result.value!.synonyms).to eq(["batmobile", "pussy wagon"])
      end
    end
  end
end
