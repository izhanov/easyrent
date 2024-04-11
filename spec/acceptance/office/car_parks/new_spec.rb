# frozen_string_literal: true

require "feature_helper"

feature "User click to New car park button" do
  scenario "see new car park form" do
    user = create(:user)
    sign_in user, scope: "office_user"
    visit new_office_car_park_path
    expect(page).to have_field("Title")
    expect(page).to have_select("City")
    expect(page).to have_field("Business id number")
    expect(page).to have_field("Email")
    expect(page).to have_field("Contact phone")
  end
end
