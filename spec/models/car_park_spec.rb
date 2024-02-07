require "rails_helper"

RSpec.describe CarPark, type: :model do
  it do
    is_expected.to have_db_column(:business_id_number).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:kind).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:city_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:user_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:title).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:legal_address).of_type(:string)
    is_expected.to have_db_column(:contact_phone).of_type(:string)
    is_expected.to have_db_column(:service_phone).of_type(:string)
    is_expected.to have_db_column(:bank_name).of_type(:string)
    is_expected.to have_db_column(:bank_account_number).of_type(:string)
    is_expected.to have_db_column(:email).of_type(:string)
    is_expected.to have_db_column(:card_id_number).of_type(:string)
    is_expected.to have_db_column(:privateer_number).of_type(:string)
    is_expected.to have_db_column(:privateer_date).of_type(:date)
    is_expected.to have_db_column(:residence_address).of_type(:string)
    is_expected.to have_db_column(:bank_code).of_type(:string)
    is_expected.to have_db_column(:benificiary_code).of_type(:string)
    is_expected.to have_db_index([:city_id, :business_id_number]).unique(true)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:city) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:cars).dependent(:destroy) }
  end

  describe "KINDS constant" do
    it "returns array of kinds" do
      expect(described_class::KINDS).to eq(%w[llp ie])
    end
  end
end
