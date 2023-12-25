# frozen_string_literal: true

require "feature_helper"

feature "Admin visit edit city page" do
  let!(:admin) { create(:admin) }
  let!(:city) { create(:city) }

  before do
    sign_in admin
    visit edit_admins_city_path(city)
  end

  scenario "and see edit city page" do
    expect(page).to have_selector("h1", text: "Edit #{city.title}")
    expect(page).to have_field("Title", with: city.title)
    expect(page).to have_field("slug", with: city.slug)
    expect(page).to have_link("Back")
  end

  context "when fill in fields with valid data" do
    scenario "and click to Update city button" do
      fill_in "Title", with: "Metropolis"
      fill_in "slug", with: "metropolis"
      click_button "Save"
      expect(page).to have_current_path(admins_city_path(city))
      expect(page).to have_selector("h1", text: "Metropolis")
      expect(page).to have_selector("h1 small", text: "metropolis")
    end
  end
end
