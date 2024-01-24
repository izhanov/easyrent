require "rails_helper"

RSpec.describe AdditionalService, type: :model do
  it do
    is_expected.to have_db_column(:title).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:slug).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:price).of_type(:decimal).with_options(null: false)
    is_expected.to have_db_column(:owner_type).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:owner_id).of_type(:integer).with_options(null: false)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:owner) }
  end
end
