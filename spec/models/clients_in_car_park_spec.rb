require "rails_helper"

RSpec.describe ClientsInCarPark, type: :model do
  it do
    is_expected.to have_db_column(:client_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:car_park_id).of_type(:integer).with_options(null: false)
  end
end
