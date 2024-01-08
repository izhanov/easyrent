# frozen_string_literal: true

require "feature_helper"

feature "Admins visit marks index page" do
  let!(:admin) { create(:admin) }
  let!(:brand) { create(:brand) }

  before do
    sign_in admin
  end

  context "when marks not exist" do
    scenario "and see message" do
      visit admins_marks_path
      expect(page).to have_content("Marks not exist")
      expect(page).to have_link("New mark")
    end
  end

  context "when marks exist" do
    scenario "and see marks list" do
      mark1 = create(:mark, brand: brand)
      mark2 = create(:mark, brand: brand)

      visit admins_marks_path
      expect(page).to have_content("Marks")
      expect(page).to have_link(mark1.title, count: 1)
      expect(page).to have_link(mark2.title, count: 1)
    end
  end
end
