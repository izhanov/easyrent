# frozen_string_literal: true

require "feature_helper"

feature "Admin visit brands edit page" do
  let!(:admin) { create(:admin) }
  let!(:brand) { create(:brand) }

  context "when admin is sign in" do
    before do
      sign_in admin
    end

    scenario "and see edit brand page" do
      visit edit_admins_brand_path(brand)
      expect(page).to have_current_path(edit_admins_brand_path(brand))
      expect(page).to have_selector("h1", text: "Edit #{brand.title}")
    end

    scenario "and see edit brand form" do
      visit edit_admins_brand_path(brand)
      expect(page).to have_field("Title")
      expect(page).to have_field("Synonyms")
      expect(page).to have_button("Save")
    end

    scenario "and fill in edit brand form" do
      visit edit_admins_brand_path(brand)
      fill_in "Title", with: "Batcar"
      fill_in "Synonyms", with: "Batmobile, Pussy Wagon, Batpod"
      click_button "Save"
      expect(page).to have_current_path(admins_brand_path(brand))
      expect(page).to have_selector("h1", text: brand.title)
    end
  end
end
