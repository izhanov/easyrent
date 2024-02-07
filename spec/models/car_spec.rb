require "rails_helper"

RSpec.describe Car, type: :model do
  it do
    is_expected.to(
      have_db_column(:mark_id).of_type(:integer).with_options(null: false)
    )
    is_expected.to(
      have_db_column(:owner_type).of_type(:string).with_options(null: false)
    )
    is_expected.to(
      have_db_column(:owner_id).of_type(:integer).with_options(null: false)
    )
    is_expected.to have_db_column(:year).of_type(:integer).with_options(limit: 2)
    is_expected.to have_db_column(:vin_code).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:plate_number).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:klass).of_type(:string)
    is_expected.to have_db_column(:technical_certificate_number).of_type(:string)
    is_expected.to have_db_column(:mileage).of_type(:integer)
    is_expected.to have_db_column(:fuel).of_type(:string)
    is_expected.to have_db_column(:color).of_type(:string)
    is_expected.to have_db_column(:transmission).of_type(:string)
    is_expected.to have_db_column(:status).of_type(:string)
    is_expected.to have_db_column(:number_of_seats).of_type(:integer)
    is_expected.to have_db_column(:tank_volume).of_type(:integer).with_options(limit: 2)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:mark) }
    it { is_expected.to belong_to(:owner) }
  end

  describe "#mark_title" do
    it "returns full mark title" do
      mark = create(:mark)
      car = build(:car, mark: mark)

      expect(car.mark_title).to eq("#{mark.brand.title} #{mark.title}")
    end
  end

  describe "FUEL_TYPES" do
    it "returns array of fuel types" do
      expect(Car::FUEL_TYPES).to eq(%w[petrol diesel gas electric])
    end
  end

  describe "KLASS_TYPES" do
    it "returns array of klass types" do
      expect(Car::KLASS_TYPES).to eq(%w[economy comfort business premium ultima])
    end
  end

  describe "TRANSMISSION_TYPES" do
    it "returns array of transmission types" do
      expect(Car::TRANSMISSION_TYPES).to eq(%w[manual automatic robotic_gearbox cvt])
    end
  end

  describe "ENGINE_CAPACITY_UNITS" do
    it "returns array of engine capacity units" do
      expect(Car::ENGINE_CAPACITY_UNITS).to eq(%w[cm3 l])
    end
  end
end
