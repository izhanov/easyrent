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
    let!(:marks_list) { create_list(:mark, 2, brand: brand) }

    scenario "and see marks list" do
      visit admins_marks_path
      expect(page).to have_content("Marks")
      marks_list.each do |mark|
        expect(page).to have_link(mark.title, count: 1)
      end
    end
  end
end
