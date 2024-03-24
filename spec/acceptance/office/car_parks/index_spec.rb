# frozen_string_literal: true

require "feature_helper"

feature "User visit car parks index page" do
  context "when user has one car park" do
    scenario "sees car park card" do
      user = create(:user)
      car_park = create(:car_park, user: user)
      sign_in user, scope: "office_user"
      visit office_car_parks_path
      expect(page).to have_content(car_park.title)
      expect(page).to have_link(car_park.title)
      expect(page).to have_xpath("//a[@href='#{office_root_path}']")
    end
  end
end
