# frozen_string_literal: true

require "feature_helper"

feature "Admin visit users index page" do
  let!(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  context "when users don't exist" do
    scenario "and see empty users index page" do
      visit admins_users_path
      expect(page).to have_selector("h1", text: "Users")
      expect(page).to have_content("No users")
      expect(page).to have_link("Invite user")
    end
  end

  context "when users exist" do
    let!(:users) { create_list(:user, 3) }

    scenario "and see users list" do
      visit admins_users_path
      users.each do |user|
        expect(page).to have_selector("tr td", text: user.email)
      end
    end
  end

  context "when click to Invite user link" do
    scenario "and see invite user form" do
      visit admins_users_path
      click_link "Invite user"
      expect(page).to have_selector("h1", text: "New user")
      expect(page).to have_field("Email")
      expect(page).to have_field("Phone")
      expect(page).to have_field("First name")
      expect(page).to have_field("Last name")
      expect(page).to have_field("Kind")
      expect(page).to have_button("Save")
    end
  end
end
