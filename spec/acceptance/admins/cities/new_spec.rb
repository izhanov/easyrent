# frozen_string_literal: true

require "feature_helper"

feature "Admin visit cities new page" do
  let!(:admin) { create(:admin) }

  before do
    sign_in admin
    visit new_admins_city_path
  end

  scenario "and see form" do
    expect(page).to have_current_path(new_admins_city_path)
    expect(page).to have_selector("h1", text: "New city")
    expect(page).to have_field("Title")
    expect(page).to have_field("slug")
    expect(page).to have_link("Back")
    expect(page).to have_button("Save")
  end

  scenario "and click to Back link" do
    click_link "Back"
    expect(page).to have_current_path(admins_cities_path)
    expect(page).to have_selector("h1", text: "Cities")
  end

  scenario "and click to Save button" do
    click_button "Save"
    expect(page).to have_selector("h1", text: "New city")
    expect(page).to have_content("title – is missing")
  end

  context "and fill form" do
    scenario "and fill form" do
      fill_in "Title", with: "Gotham"
      fill_in "slug", with: "gotham"
      click_button "Save"
      expect(page).to have_current_path(admins_cities_path)
      expect(page).to have_selector("h1", text: "Cities")
      expect(page).to have_selector "a", text: "Gotham"
    end
  end
end
