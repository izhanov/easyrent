# frozen_string_literal: true

require "rails_helper"

RSpec.describe Consumable, type: :model do
  it do
    is_expected.to have_db_column(:car_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:title).of_type(:string)
    is_expected.to have_db_column(:description).of_type(:string)
    is_expected.to have_db_column(:lifetime).of_type(:integer)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:car) }
    it { is_expected.to have_many(:consumable_logs).dependent(:destroy) }
  end

  describe "TITLES" do
    it "returns array of titles" do
      expect(Consumable::TITLES).to(
        eq(
          %w[
            engine_oil
            brake_fluid
            transmission_oil
            antifreeze
            power_steering_fluid
            air_filter
            fuel_filter
            cabin_filter
            spark_plug
            timing_belt
            timing_chain
            brake_pads
            brake_discs
            clutch_kit
            shock_absorber
            stabilizer_link
            tie_rod_end
            ball_joint
            wheel_hub
          ]
        )
      )
    end
  end

  describe "#title_ru" do
    before do
      I18n.locale = :ru
    end

    after do
      I18n.locale = :en
    end

    it "returns title_ru" do
      consumable = build(:consumable, title: "engine_oil")
      expect(consumable.title_ru).to eq("Моторное масло")
    end
  end
end
