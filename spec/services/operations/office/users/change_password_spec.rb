# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Office::Users::ChangePassword do
  describe "#call" do
    context "when user can't be found" do
      it "return failure user not found" do
        result = subject.call(1, "12345678", "12345678")
        expect(result).to be_failure
        expect(result.failure).to include(:user_not_found)
      end
    end

    context "when user is found" do
      context "when password and password confirmation are not equal" do
        it "returns failure password and password confirmation are not equal" do
          user = create(:user)
          result = subject.call(user.id, "12345678", "87654321")
          expect(result).to be_failure
          expect(result.failure).to include(:password_and_password_confirmation_are_not_equal)
        end
      end

      context "when new password is equal to temp password" do
        it "returns failure new password can't be equal to temp password" do
          user = create(:user, temp_password: "12345678")
          result = subject.call(user.id, "12345678", "12345678")
          expect(result).to be_failure
          expect(result.failure).to include(:new_password_can_t_be_equal_to_temp_password)
        end
      end

      context "when new password is acceptable" do
        it "returns success with user" do
          user = create(:user, temp_password: "12345678")
          result = subject.call(user.id, "87654321", "87654321")
          expect(result).to be_success
          expect(result.value!).to eq(user)
        end
      end
    end
  end
end
