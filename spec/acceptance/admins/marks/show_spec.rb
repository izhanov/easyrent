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
    expect(page).to have_xpath("//a[@href='#{admins_catalogues_path}']")
    expect(page).to have_xpath("//a[@href='#{edit_admins_mark_path(mark)}']")
    expect(page).to have_xpath("//a[@href='#{admins_mark_path(mark)}']")
  end

  scenario "and click to Back link" do
    visit admins_mark_path(mark)
    find("//a[@href='#{admins_marks_path}']").click
    expect(page).to have_current_path(admins_marks_path)
    expect(page).to have_selector("h1", text: "Marks")
  end

  scenario "and click to Edit mark link" do
    visit admins_mark_path(mark)
    find("//a[@href='#{edit_admins_mark_path(mark)}']").click
    expect(page).to have_current_path(edit_admins_mark_path(mark))
    expect(page).to have_selector("h1", text: "Edit #{mark.title}")
  end

  context "when click to Destroy mark link", js: true do
    scenario "and see marks page" do
      visit admins_mark_path(mark)
      find(".btn.btn-sm.btn-danger").click
      expect(page).to have_current_path(admins_marks_path)
    end
  end
end
