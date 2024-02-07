# frozen_string_literal: true

require "feature_helper"

feature "Admins visit mark's edit page" do
  let!(:admin) { create(:admin) }
  let!(:mark) { create(:mark) }

  before do
    sign_in admin
  end

  scenario "and see mark's edit page" do
    visit edit_admins_mark_path(mark)
    expect(page).to have_current_path(edit_admins_mark_path(mark))
    expect(page).to have_selector("h1", text: "Edit #{mark.title}")
    expect(page).to have_xpath("//a[@href='#{admins_mark_path(mark)}']")
  end

  context "when fill in fields with valid data" do
    scenario "and click to Update mark button" do
      visit edit_admins_mark_path(mark)
      fill_in "Title", with: "Batcar"
      page.select "Sedan", from: "Body"
      fill_in "Synonyms", with: "Batmobile, Pussy Wagon, Batpod"
      click_button "Save"
      expect(page).to have_current_path(admins_mark_path(mark))
      expect(page).to have_selector("h1", text: "Batcar")
      expect(page).to have_selector("ul li", text: mark.brand.title)
    end
  end
end
