# frozen_string_literal: true

require "feature_helper"

feature "Admin visit brands edit page" do
  context "when admin is sign in" do
    scenario "and see edit brand page" do
      admin = create(:admin)
      brand = create(:brand)
      sign_in admin
      visit edit_admins_brand_path(brand)
      expect(page).to have_current_path(edit_admins_brand_path(brand))
      expect(page).to have_selector("h1", text: "Edit #{brand.title}")
    end

    scenario "and see edit brand form" do
      admin = create(:admin)
      brand = create(:brand)
      sign_in admin
      visit edit_admins_brand_path(brand)
      expect(page).to have_field("Title")
      expect(page).to have_field("Synonyms")
      expect(page).to have_button("Save")
    end

    scenario "and fill in edit brand form" do
      admin = create(:admin)
      brand = create(:brand)
      sign_in admin
      visit edit_admins_brand_path(brand)
      fill_in "Title", with: "Batcar"
      fill_in "Synonyms", with: "Batmobile, Pussy Wagon, Batpod"
      click_button "Save"
      expect(page).to have_current_path(admins_brand_path(brand))
      expect(page).to have_selector("h1", text: brand.reload.title)
    end
  end
end
