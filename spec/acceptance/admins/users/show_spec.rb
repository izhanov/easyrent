# frozen_string_literal: true

require "feature_helper"

feature "Admin visit users show page" do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  before do
    sign_in admin
  end

  scenario "and see user's credentials" do
    visit admins_user_path(user)
    expect(page).to have_current_path(admins_user_path(user))
    expect(page).to have_selector("h1", text: user.full_name)
    expect(page).to have_selector("ul li", text: user.email)
  end

  context "when click to Edit link" do
    scenario "and see edit user form" do
      visit admins_user_path(user)
      click_link "Edit"
      expect(page).to have_selector("h1", text: "Edit #{user.full_name}")
      expect(page).to have_field("Email")
      expect(page).to have_field("Phone")
      expect(page).to have_field("First name")
      expect(page).to have_field("Last name")
      expect(page).to have_field("Kind")
      expect(page).to have_button("Save")
    end
  end

  context "when click to Delete link" do
    scenario "redirect to users page list and delete user" do
      visit admins_user_path(user)
      click_link "Destroy"
      expect(page).to have_current_path(admins_users_path)
      expect(page).to have_selector("h1", text: "Users")
      expect(page).to have_selector("div", text: "User successfully destroyed.")
    end
  end
end
