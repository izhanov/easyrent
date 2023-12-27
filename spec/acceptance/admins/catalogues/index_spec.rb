# frozen_string_literal: true

require "feature_helper"

feature "Admin visit catalogues index page" do
  let!(:admin) { create(:admin) }

  context "when admin isn't sign in" do
    scenario "and see sign in page" do
      visit admins_catalogues_path
      expect(page).to have_current_path(new_admin_session_path)
    end
  end

  context "when admin is sign in" do
    before do
      sign_in admin
    end

    scenario "and see catalogues page" do
      visit admins_catalogues_path
      expect(page).to have_current_path(admins_catalogues_path)
      expect(page).to have_selector("h1", text: "Catalogues")
    end

    scenario "and see catalogues list" do
      visit admins_catalogues_path
      expect(page).to have_link("Brands")
      expect(page).to have_link("Marks")
    end

    scenario "and clieck to brands link" do
      visit admins_catalogues_path
      click_link "Brands"
      expect(page).to have_current_path(admins_brands_path)
    end

    scenario "and clieck to marks link" do
      visit admins_catalogues_path
      click_link "Marks"
      expect(page).to have_current_path(admins_marks_path)
    end
  end
end
