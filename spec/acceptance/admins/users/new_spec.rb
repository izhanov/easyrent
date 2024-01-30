# frozen_string_literal: true

require "feature_helper"

feature "Admin visits a new user page" do
  let!(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  context "when fill in fields with valid data" do
    scenario "and click to Save button" do
      visit new_admins_user_path
      fill_in "Email", with: Faker::Internet.email
      fill_in "Phone", with: "+7(999)999-99-99"
      fill_in "First name", with: Faker::Name.first_name
      fill_in "Last name", with: Faker::Name.last_name
      page.select "l", from: "Kind"
      click_button "Save"
      expect(page).to have_current_path(admins_user_path(User.last))
    end
  end

  context "when fill in fields with invalid data" do
    scenario "and see errors", js: true do
      visit new_admins_user_path
      fill_in "Email", with: ""
      fill_in "Phone", with: "77002552209"
      click_button "Save"
      expect(page).to have_content("Validation error.")
    end
  end

  context "when fill in email field with existing email" do
    scenario "and see violation error", js: true do
      exits_user = create(:user)
      visit new_admins_user_path
      fill_in "Email", with: exits_user.email
      fill_in "First name", with: Faker::Name.first_name
      fill_in "Last name", with: Faker::Name.last_name
      find("#user_phone").click
      fill_in "user[phone]", with: "77002571218"
      page.select "l", from: "Kind"
      click_button "Save"
      expect(page).to have_content("User with this email already exists.")
    end
  end
end
