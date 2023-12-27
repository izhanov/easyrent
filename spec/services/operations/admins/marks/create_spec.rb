# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Admins::Marks::Create do
  describe "#call" do
    context "when params invalid" do
      it "returns failure with errors" do
        result = subject.call({})

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params valid" do
      let!(:brand) { create(:brand) }
      let(:params) do
        {
          brand_id: brand.id,
          title: "Snowball",
          body: "sedan",
          synonyms: ["ball", "blue haze"]
        }
      end

      it "creates mark" do
        result = subject.call(params)
        mark = result.value!

        expect(result).to be_a(Dry::Monads::Success)
        expect(mark).to be_a(Mark)
        expect(mark.title).to eq("Snowball")
        expect(mark.synonyms).to eq(["ball", "blue haze"])
      end
    end
  end
end
