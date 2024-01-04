require "rails_helper"

RSpec.describe Brand, type: :model do
  it do
    is_expected.to(
      have_db_column(:title).of_type(:string).with_options(null: false)
    )
  end

  it do
    is_expected.to(
      have_db_column(:synonyms).of_type(:jsonb)
        .with_options(default: [], null: false)
    )
  end

  describe "Associations" do
    it { is_expected.to have_many(:marks).dependent(:destroy) }
  end
end
