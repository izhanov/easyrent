require "rails_helper"

RSpec.describe Car, type: :model do
  it do
    is_expected.to(
      have_db_column(:mark_id).of_type(:integer).with_options(null: false)
    )
    is_expected.to(
      have_db_column(:ownerable_type).of_type(:string).with_options(null: false)
    )
    is_expected.to(
      have_db_column(:ownerable_id).of_type(:integer).with_options(null: false)
    )
    is_expected.to have_db_column(:year).of_type(:string)
    is_expected.to have_db_column(:vin_code).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:plate_number).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:klass).of_type(:string)
    is_expected.to have_db_column(:technical_certificate_number).of_type(:string)
    is_expected.to have_db_column(:mileage).of_type(:string)
    is_expected.to have_db_column(:fuel).of_type(:string)
    is_expected.to have_db_column(:color).of_type(:string)
    is_expected.to have_db_column(:transmission).of_type(:string)
    is_expected.to have_db_column(:status).of_type(:string)
    is_expected.to have_db_column(:number_of_seats).of_type(:string)
    is_expected.to have_db_column(:tank_volume).of_type(:string)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:mark) }
    it { is_expected.to belong_to(:ownerable) }
  end
end
