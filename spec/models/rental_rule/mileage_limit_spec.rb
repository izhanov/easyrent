require "rails_helper"

RSpec.describe RentalRule::MileageLimit, type: :model do
  it do
    is_expected.to have_db_column(:owner_type).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:owner_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:value).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:title).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:markup).of_type(:integer).with_options(default: 0, null: false)
    is_expected.to have_db_column(:discount).of_type(:integer).with_options(default: 0, null: false)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:owner) }
  end
end
