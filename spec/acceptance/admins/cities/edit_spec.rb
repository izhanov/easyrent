# frozen_string_literal: true

require "feature_helper"

feature "Admin visit edit city page" do
  let!(:admin) { create(:admin) }
  let!(:city) { create(:city) }

  before do
    sign_in admin
  end

  scenario "and see edit city page" do
    visit edit_admins_city_path(city)

    expect(page).to have_selector("h1", text: "Edit #{city.title}")
    expect(page).to have_field("Title", with: city.title)
    expect(page).to have_field("slug", with: city.slug)
    expect(page).to have_xpath("//a[@href='#{admins_city_path(city)}']")
  end

  context "when fill in fields with valid data" do
    scenario "and click to Update city button" do
      visit edit_admins_city_path(city)
      fill_in "Title", with: "Metropolis"
      fill_in "slug", with: "metropolis"
      click_button "Save"
      expect(page).to have_current_path(admins_city_path(city))
      expect(page).to have_selector("h1", text: "Metropolis")
      expect(page).to have_selector("h1 small", text: "metropolis")
    end
  end

  context "when fill in fields with invalid data" do
    scenario "and click to Update city button", js: true do
      visit edit_admins_city_path(city)
      fill_in "Title", with: ""
      click_button "Save"
      expect(page).to have_selector("h1", text: "Edit #{city.title}")
      expect(page).to have_content("Validation error")
    end
  end

  context "when click to Back link" do
    scenario "and see cities page" do
      visit edit_admins_city_path(city)
      find("#cities-back-link").click
      expect(page).to have_current_path(admins_city_path(city))
      expect(page).to have_selector("h1", text: city.title)
    end
  end
end
