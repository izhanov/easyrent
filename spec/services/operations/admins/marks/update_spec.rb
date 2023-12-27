# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Admins::Marks::Update do
  describe "#call" do
    context "when params invalid" do
      let!(:mark) { create(:mark) }

      it "returns failure with errors" do
        result = subject.call(mark, {brand_id: "a"})

        expect(result).to be_a(Dry::Monads::Failure)
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params valid" do
      let!(:mark) { create(:mark) }
      let(:params) do
        {
          title: "Snowball",
          body: "sedan",
          synonyms: ["ball", "blue haze"]
        }
      end

      it "updates mark" do
        result = subject.call(mark, params)
        updated_mark = result.value!

        expect(result).to be_a(Dry::Monads::Success)
        expect(updated_mark).to be_a(Mark)
        expect(updated_mark.title).to eq("Snowball")
        expect(updated_mark.synonyms).to eq(["ball", "blue haze"])
        expect(updated_mark.body).to eq("sedan")
      end
    end
  end
end
