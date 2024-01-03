# frozen_string_literal: true

require "feature_helper"

feature "Admin vist edit user page" do
  scenario "and see edit user form" do
    admin = create(:admin)
    user = create(:user)
    sign_in admin

    visit admins_user_path(user)
    click_link "Edit"
    expect(page).to have_selector("h1", text: "Edit #{user.full_name}")
    expect(page).to have_field("Email")
    expect(page).to have_field("Phone")
    expect(page).to have_field("First name")
    expect(page).to have_field("Last name")
    expect(page).to have_field("Kind")
    expect(page).to have_button("Save")
  end
end
