# frozen_string_literal: true

require "feature_helper"

feature "Admin visit marks show page" do
  let!(:admin) { create(:admin) }
  let!(:mark) { create(:mark) }

  before do
    sign_in admin
  end

  scenario "and see mark" do
    visit admins_mark_path(mark)
    expect(page).to have_current_path(admins_mark_path(mark))
    expect(page).to have_selector("h1", text: mark.title)
    expect(page).to have_link("Back")
    expect(page).to have_link("Edit")
    expect(page).to have_link("Destroy")
  end

  scenario "and click to Back link" do
    visit admins_mark_path(mark)
    click_link "Back"
    expect(page).to have_current_path(admins_marks_path)
    expect(page).to have_selector("h1", text: "Marks")
  end

  scenario "and click to Edit mark link" do
    visit admins_mark_path(mark)
    click_link "Edit"
    expect(page).to have_current_path(edit_admins_mark_path(mark))
    expect(page).to have_selector("h1", text: "Edit #{mark.title}")
  end

  context "when click to Destroy mark link" do
    scenario "and see marks page" do
      visit admins_mark_path(mark)
      click_link "Destroy"
      expect(page).to have_current_path(admins_marks_path)
    end
  end
end
