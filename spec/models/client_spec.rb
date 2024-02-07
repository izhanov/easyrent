require "rails_helper"

RSpec.describe Client, type: :model do
  it do
    is_expected.to have_db_column(:name).of_type(:string)
    is_expected.to have_db_column(:surname).of_type(:string)
    is_expected.to have_db_column(:patronymic).of_type(:string)
    is_expected.to have_db_column(:email).of_type(:string)
    is_expected.to have_db_column(:passport_number).of_type(:string)
    is_expected.to have_db_column(:driving_license).of_type(:string)
    is_expected.to have_db_column(:driving_license_issued_date).of_type(:date)
    is_expected.to have_db_column(:citizen).of_type(:boolean)
    is_expected.to have_db_column(:kind).of_type(:string)
    is_expected.to have_db_column(:phone).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:identification_number).of_type(:string)
    is_expected.to have_db_index(:identification_number).unique(true)
    is_expected.to have_db_index(:phone).unique(true)
  end
end
