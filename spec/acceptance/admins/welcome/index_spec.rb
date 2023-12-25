# frozen_string_literal: true

require "feature_helper"

feature "Admin visit welcome page" do
  let!(:admin) { create(:admin) }

  scenario "and see welcome message" do
    sign_in admin

    visit admins_root_path
    expect(page).to have_current_path(admins_root_path)
    expect(page).to have_content("Welcome to the admin panel")
  end

  scenario "and click to Users link" do
    sign_in admin

    visit admins_root_path
    click_link "Users"
    expect(page).to have_current_path(admins_users_path)
    expect(page).to have_selector("h1", text: "Users")
  end

  scenario "and click to Car parks link" do
    sign_in admin

    visit admins_root_path
    click_link "Cities"
    expect(page).to have_current_path(admins_cities_path)
    expect(page).to have_selector("h1", text: "Cities")
  end
end
