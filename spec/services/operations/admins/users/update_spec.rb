# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Admins::Users::Update do
  describe "#call" do
    let(:user) { create(:user) }

    context "when params are invalid" do
      it "returns failure with errors" do
        result = subject.call(user, {kind: "invalid"})
        expect(result).to be_failure
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params are valid" do
      let(:params) do
        {
          first_name: "Lex",
          last_name: "Doe",
          email: "john@mail.com",
          phone: "+7(700)267-23-88",
          kind: "M"
        }
      end

      it "returns succes with user" do
        result = subject.call(user, params)
        user = result.value!
        expect(result).to be_success
        expect(user).to be_a(User)
      end
    end
  end
end
