# frozen_string_literal: true

require "feature_helper"

feature "Admin visit cities page" do
  let!(:admin) { create(:admin) }

  before do
    sign_in admin
  end

  context "when cities not exist" do
    scenario "and see message" do
      visit admins_cities_path
      expect(page).to have_current_path(admins_cities_path)
      expect(page).to have_content("Cities not exist")
      expect(page).to have_xpath("//a[@href='#{new_admins_city_path}']")
    end

    scenario "and click to New city link" do
      visit admins_cities_path
      find("//a[@href='#{new_admins_city_path}']").click
      expect(page).to have_current_path(new_admins_city_path)
      expect(page).to have_selector("h1", text: "New city")
      expect(page).to have_xpath("//a[@href='#{admins_cities_path}']")
    end
  end

  context "when cities exist" do
    let!(:city) { create(:city) }

    scenario "and see cities list" do
      visit admins_cities_path
      expect(page).to have_current_path(admins_cities_path)
      expect(page).to have_content("Cities")
      expect(page).to have_link("Gotham")
    end
  end
end
