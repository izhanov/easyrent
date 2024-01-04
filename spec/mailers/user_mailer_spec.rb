# frozen_sring_literal: true

require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe ".invite_user" do
    it "renders the headers" do
      user = create(:user)
      mail = UserMailer.invite_user(user).deliver_now
      expect(mail.subject).to eq("Invite user")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      user = create(:user)
      mail = UserMailer.invite_user(user).deliver_now
      email_body = mail.body.encoded
      expect(email_body).to match("Hello #{user.first_name}!")
      expect(email_body).to match("You have been invited to join easyrent.kz with your #{user.email}")
      expect(email_body).to match("And use Your temporary password: #{user.temp_password}")
      expect(email_body).to match("Don't forget to change your password after login. Good luck!")
    end
  end
end
