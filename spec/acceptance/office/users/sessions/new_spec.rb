# frozen_string_literal: true

require "feature_helper"

feature "User sign in" do
  context "with temp password" do
    scenario "successfully signed in and redirected to temp password page" do
      user = create(
        :user,
        password: "12345678",
        temp_password: "12345678",
        password_confirmation: "12345678"
      )

      visit new_office_user_session_path
      fill_in "office_user[email]", with: user.email
      fill_in "office_user[password]", with: "12345678"
      click_button "Submit"
      expect(page).to have_current_path(edit_office_temp_password_path)
      expect(page).to have_content("We found that you signed in with a temporary password")
      expect(page).to have_content("For the security and safety of your data")
      expect(page).to have_content("we strongly ask you to change it to a permanent one.")
    end
  end

  context "with permanent password" do
    scenario "with wrong email" do
      visit new_office_user_session_path
      fill_in "office_user[email]", with: "hhh@mail.com"
      fill_in "office_user[password]", with: "12345678"
      click_button "Submit"
      expect(page).to have_current_path(new_office_user_session_path)
    end

    scenario "with wrong password" do
      user = create(:user)
      visit new_office_user_session_path
      fill_in "office_user[email]", with: user.email
      fill_in "office_user[password]", with: "wrong password"
      click_button "Submit"
      expect(page).to have_current_path(new_office_user_session_path)
    end

    scenario "with correct email and password" do
      user = create(:user)
      visit new_office_user_session_path
      fill_in "office_user[email]", with: user.email
      fill_in "office_user[password]", with: user.password
      click_button "Submit"
      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_current_path(office_root_path)
    end
  end
end
