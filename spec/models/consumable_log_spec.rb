# frozen_string_literal: true

require "rails_helper"

RSpec.describe ConsumableLog, type: :model do
  it do
    is_expected.to have_db_column(:consumable_id).of_type(:integer)
    is_expected.to have_db_column(:date).of_type(:date)
    is_expected.to have_db_column(:mileage_when_replacing).of_type(:integer)
    is_expected.to have_db_column(:mileage_at_next_replacing).of_type(:integer)
    is_expected.to have_db_column(:description).of_type(:string)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:consumable) }
  end
end
