# frozen_string_literal: true

require "feature_helper"

feature "User visit car parks index page" do
  context "when user hasn't any car park" do
    scenario "sees notification alert" do
      user = create(:user)
      sign_in user, scope: "office_user"
      visit office_user_car_parks_path(user)
      expect(page).to have_content("You have no car parks. To start working you need to create at least one car park.")
      expect(page).to have_link("New car park")
    end
  end

  context "when user has one car park" do
    scenario "sees car park card" do
      user = create(:user)
      car_park = create(:car_park, user: user)
      sign_in user, scope: "office_user"
      visit office_user_car_parks_path(user)
      expect(page).to have_content(car_park.title)
      expect(page).to have_link(car_park.title)
      expect(page).to have_xpath("//a[@href='#{office_root_path}']")
    end
  end
end
