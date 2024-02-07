require "rails_helper"

RSpec.describe PriceRangeCell, type: :model do
  it do
    is_expected.to(have_db_column(:price_range_id).of_type(:integer).with_options(null: false))
    is_expected.to(have_db_column(:from).of_type(:integer).with_options(null: false))
    is_expected.to(have_db_column(:to).of_type(:integer).with_options(null: false))
  end
end
