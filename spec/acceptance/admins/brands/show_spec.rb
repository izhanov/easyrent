# frozen_string_literal: true

require "feature_helper"

feature "Admin visit brands show page" do
  let!(:admin) { create(:admin) }
  let!(:brand) { create(:brand) }

  before do
    sign_in admin
    visit admins_brand_path(brand)
  end

  scenario "and see brand page" do
    expect(page).to have_current_path(admins_brand_path(brand))
    expect(page).to have_selector("h1", text: brand.title)
    expect(page).to have_content(brand.synonyms.join(", "))
  end

  scenario "and see edit, destroy and back links" do
    expect(page).to have_link("Edit")
    expect(page).to have_link("Destroy")
    expect(page).to have_link("Back")
  end
end
