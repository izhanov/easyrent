# frozen_string_literal: true

require "feature_helper"

feature "Admin visit brands show page" do
  let!(:admin) { create(:admin) }
  let!(:brand) { create(:brand) }

  before do
    sign_in admin
  end

  scenario "and see brand page" do
    visit admins_brand_path(brand)
    expect(page).to have_current_path(admins_brand_path(brand))
    expect(page).to have_selector("h1", text: brand.title)
    expect(page).to have_content(brand.synonyms.join(", "))
  end

  scenario "and see edit, destroy and back links" do
    visit admins_brand_path(brand)
    expect(page).to have_xpath("//a[@href='#{edit_admins_brand_path(brand)}']")
    expect(page).to have_xpath("//a[@href='#{admins_brand_path(brand)}']")
    expect(page).to have_xpath("//a[@href='#{admins_catalogues_path}']")
  end

  scenario "and click to edit link" do
    visit admins_brand_path(brand)
    find("//a[@href='#{edit_admins_brand_path(brand)}']").click
    expect(page).to have_current_path(edit_admins_brand_path(brand))
  end

  scenario "and click to destroy link", js: true do
    visit admins_brand_path(brand)

    accept_prompt do
      find(".btn.btn-sm.btn-danger").click
    end
    expect(page).to have_current_path(admins_brands_path)
    expect(page).to have_content("Brand was successfully destroyed")
  end
end
