# frozen_string_literal: true

require "feature_helper"

feature "Admin visit cities page" do
  let!(:admin) { create(:admin) }

  context "when cities not exist" do
    before do
      sign_in admin
      visit admins_cities_path
    end

    scenario "and see message" do
      expect(page).to have_current_path(admins_cities_path)
      expect(page).to have_content("Cities not exist")
      expect(page).to have_link("New city")
    end

    scenario "and click to New city link" do
      click_link "New city"
      expect(page).to have_current_path(new_admins_city_path)
      expect(page).to have_selector("h1", text: "New city")
      expect(page).to have_link("Back")
    end
  end
end
