# frozen_string_literal: true

require "feature_helper"

feature "Admin visit brands new page" do
  context "when admin is sign in" do
    let!(:admin) { create(:admin) }

    before do
      sign_in admin
    end

    scenario "and see new brand page" do
      visit new_admins_brand_path
      expect(page).to have_current_path(new_admins_brand_path)
      expect(page).to have_selector("h1", text: "New brand")
    end

    scenario "and see new brand form" do
      visit new_admins_brand_path
      expect(page).to have_field("Title")
      expect(page).to have_field("Synonyms")
      expect(page).to have_button("Save")
    end

    scenario "and fill in new brand form" do
      visit new_admins_brand_path
      fill_in "Title", with: "Batcar"
      fill_in "Synonyms", with: "Batmobile, Pussy Wagon, Batpod"
      click_button "Save"
      expect(page).to have_current_path(admins_brands_path)
      expect(page).to have_selector("h1", text: "Brands")
      expect(page).to have_content("Batcar")
    end

    scenario "when fill title field with existing title", js: true do
      brand = create(:brand)
      visit new_admins_brand_path
      fill_in "Title", with: brand.title
      click_button "Save"
      expect(page).to have_content("Brand already exists.")
    end
  end
end
