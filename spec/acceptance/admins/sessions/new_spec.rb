# frozen_string_literal: true

require "feature_helper"

feature "Admin sign in" do
  let!(:admin) { create(:admin) }

  scenario "Admin sign in with invalid data" do
    visit new_admin_session_path

    page.fill_in "admin[email]", with: "bad@mail.com"
    page.fill_in "admin[password]", with: "wrong password"

    click_button "Submit"
    expect(page).to have_current_path(new_admin_session_path)
  end

  scenario "Admin sign in with valid data" do
    visit new_admin_session_path

    page.fill_in "admin[email]", with: admin.email
    page.fill_in "admin[password]", with: admin.password

    click_button "Submit"
    expect(page).to have_current_path(admins_root_path)
  end
end
