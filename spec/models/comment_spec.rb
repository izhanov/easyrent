require "rails_helper"

RSpec.describe Comment, type: :model do
  it do
    is_expected.to have_db_column(:commentable_type).of_type(:string).with_options(null: false)
    is_expected.to have_db_column(:commentable_id).of_type(:integer).with_options(null: false)
    is_expected.to have_db_column(:content).of_type(:text)
  end

  describe "Associations" do
    it { is_expected.to belong_to(:commentable) }
  end
end
