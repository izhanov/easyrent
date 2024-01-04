require "rails_helper"

RSpec.describe City, type: :model do
  it do
    is_expected.to(
      have_db_column(:title).of_type(:string).with_options(null: false)
    )
    is_expected.to(
      have_db_column(:slug).of_type(:string).with_options(null: true)
    )
  end
end
