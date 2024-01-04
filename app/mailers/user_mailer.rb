# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def invite_user(user)
    @user = user
    mail(to: @user.email)
  end
end
