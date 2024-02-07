require "rails_helper"

RSpec.describe Booking, type: :model do
  it do
    is_expected.to have_db_column(:car_id).of_type(:integer).with_options(null: false)

  end
end
