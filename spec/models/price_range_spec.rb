require "rails_helper"

RSpec.describe PriceRange, type: :model do
  it {
    is_expected.to(have_db_column(:owner_id).of_type(:integer).with_options(null: false))
    is_expected.to(have_db_column(:unit).of_type(:string).with_options(null: false))
  }
end
