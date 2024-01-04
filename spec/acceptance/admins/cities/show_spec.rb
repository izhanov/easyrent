# frozen_string_literal: true

require "feature_helper"

feature "Admin visit cities show page" do
  let!(:admin) { create(:admin) }
  let!(:city) { create(:city) }

  before do
    sign_in admin
  end

  scenario "and see city" do
    visit admins_city_path(city)
    expect(page).to have_current_path(admins_city_path(city))
    expect(page).to have_selector("h1", text: city.title)
    expect(page).to have_selector("h1 small", text: city.slug)
    expect(page).to have_link("Back")
    expect(page).to have_link("Edit city")
    expect(page).to have_link("Destroy city")
  end

  scenario "and click to Back link" do
    visit admins_city_path(city)
    click_link "Back"
    expect(page).to have_current_path(admins_cities_path)
    expect(page).to have_selector("h1", text: "Cities")
  end

  scenario "and click to Edit city link" do
    visit admins_city_path(city)
    click_link "Edit city"
    expect(page).to have_current_path(edit_admins_city_path(city))
    expect(page).to have_selector("h1", text: "Edit #{city.title}")
  end

  context "when click to Destroy city link" do
    scenario "and see cities page" do
      visit admins_city_path(city)
      click_link "Destroy city"
      expect(page).to have_current_path(admins_cities_path)
    end
  end
end
