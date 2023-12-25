require "rails_helper"

RSpec.describe Mark, type: :model do
  it do
    is_expected.to(
      have_db_column(:title).of_type(:string).with_options(null: false)
    )
  end

  describe "Associations" do
    it { is_expected.to belong_to(:brand) }
  end
end
