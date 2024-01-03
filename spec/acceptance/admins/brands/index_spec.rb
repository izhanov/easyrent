# frozen_string_literal: true

require "feature_helper"

feature "Admin visit brands index page" do
  context "when admin isn't sign in" do
    scenario "and see sign in page" do
      visit admins_brands_path
      expect(page).to have_current_path(new_admin_session_path)
    end
  end

  context "when admin is sign in" do
    let!(:admin) { create(:admin) }
    let!(:brand) { create(:brand) }

    before do
      sign_in admin
      visit admins_brands_path
    end

    scenario "and see brands page" do
      expect(page).to have_current_path(admins_brands_path)
      expect(page).to have_selector("h1", text: "Brands")
    end

    scenario "and see brands list" do
      expect(page).to have_link("New brand")
      expect(page).to have_link(brand.title)
    end

    scenario "and click to new brand link" do
      click_link "New brand"
      expect(page).to have_current_path(new_admins_brand_path)
    end
  end
end
