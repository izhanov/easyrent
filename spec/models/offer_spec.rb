require "rails_helper"

RSpec.describe Offer, type: :model do
  it do
    is_expected.to have_db_column(:car_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:prices).of_type(:jsonb).with_options(null: false, default: {})
  end

  describe "Associations" do
    it { is_expected.to belong_to(:car) }
  end
end
