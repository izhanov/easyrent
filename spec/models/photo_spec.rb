require "rails_helper"

RSpec.describe Photo, type: :model do
  it do
    is_expected.to have_db_column(:car_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:image_data).of_type(:text)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:car) }
  end
end
