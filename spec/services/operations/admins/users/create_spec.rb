# frozen_string_literal: true

require "rails_helper"

RSpec.describe Operations::Admins::Users::Create do
  describe "#call" do
    context "when params are invalid" do
      it "returns failure with errors" do
        result = subject.call({})
        expect(result).to be_failure
        expect(result.failure).to include(:validation_error)
      end
    end

    context "when params are valid" do
      let(:params) do
        {
          first_name: "John",
          last_name: "Doe",
          email: "john@mail.com",
          phone: "+7(700)267-23-88",
          kind: "S"
        }
      end

      it "returns succes with user" do
        result = subject.call(params)
        user = result.value!
        expect(result).to be_success
        expect(user).to be_a(User)
      end

      it "enqueues email job", type: :job do
        expect { subject.call(params) }.to(
          have_enqueued_job(ActionMailer::MailDeliveryJob).with(
            "UserMailer",
            "invite_user",
            "deliver_now",
            Hash # It's stands for args in UserMailer#deliver_now(user)
                 # seems tricky, but I couldn't find a better way to test it
          )
        )
      end
    end
  end
end
