# frozen_string_literal: true

require "feature_helper"

feature "Admin visit marks new page" do
  scenario "and see new mark page" do
    admin = create(:admin)
    sign_in admin
    visit new_admins_mark_path
    expect(page).to have_current_path(new_admins_mark_path)
    expect(page).to have_selector("h1", text: "New mark")
  end

  scenario "and see form to create new mark" do
    admin = create(:admin)
    sign_in admin
    create(:brand)
    visit new_admins_mark_path
    expect(page).to have_field("mark[title]")
    expect(page).to have_field("mark[brand_id]")
    expect(page).to have_button("Save")
  end

  scenario "and create new mark" do
    admin = create(:admin)
    brand = create(:brand)
    sign_in admin
    visit new_admins_mark_path
    page.fill_in "mark[title]", with: "Gotham Knight"
    page.select brand.title, from: "mark[brand_id]"
    page.select "Sedan", from: "mark[body]"
    click_button "Save"
    expect(page).to have_current_path(admins_mark_path(Mark.last))
    expect(page).to have_content("Gotham Knight")
  end

  scenario "and try create new mark with invalid data" do
    admin = create(:admin)
    sign_in admin
    visit new_admins_mark_path
    click_button "Save"
    expect(page).to have_current_path(admins_marks_path)
  end

  scenario "and try create new mark with exist title", js: true do
    admin = create(:admin)
    sign_in admin
    brand = create(:brand, title: "Gotham Finest")
    exist_mark = create(:mark, title: "Gotham Knight II", brand: brand)
    visit new_admins_mark_path
    page.fill_in "mark[title]", with: exist_mark.title
    page.select brand.title, from: "mark[brand_id]"
    page.select "Sedan", from: "mark[body]"
    click_button "Save"
    expect(page).to have_current_path(admins_marks_path)
    expect(page).to have_content("Mark already exist")
  end
end
