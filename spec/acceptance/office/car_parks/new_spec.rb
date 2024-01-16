# frozen_string_literal: true

require "feature_helper"

feature "User click to New car park button" do
  scenario "successfully redirected to new car park page" do
    user = create(:user)
    sign_in user, scope: "office_user"
    visit office_user_car_parks_path(user)
    click_link "New car park"
    expect(page).to have_current_path(new_office_user_car_park_path(user))
    expect(page).to have_content("New car park")
  end

  scenario "see new car park form" do
    user = create(:user)
    sign_in user, scope: "office_user"
    visit new_office_user_car_park_path(user)
    expect(page).to have_field("Title")
    expect(page).to have_select("City")
    expect(page).to have_field("Business id number")
    expect(page).to have_field("Email")
    expect(page).to have_field("Contact phone")
  end
end
