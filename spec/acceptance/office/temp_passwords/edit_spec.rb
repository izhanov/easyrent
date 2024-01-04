# frozen_string_literal: true

require "feature_helper"

feature "User sign in with temp password" do
  scenario "successfully signed in and redirected to edit temp password page" do
    user = create(:user, :with_temp_password)
    sign_in user, scope: "office_user"
    visit office_root_path
    expect(page).to have_current_path(edit_office_temp_password_path)
    expect(page).to have_content("We found that you signed in with a temporary password")
  end

  context "when user change temp password" do
    scenario "successfully signed in and redirected to office root page" do
      user = create(:user, :with_temp_password)
      sign_in user, scope: "office_user"
      visit edit_office_temp_password_path
      fill_in "New password", with: "87654321"
      fill_in "New password confirmation", with: "87654321"
      click_button "Save"
      expect(page).to have_current_path(office_root_path)
    end
  end
end
