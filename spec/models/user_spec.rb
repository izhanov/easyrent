require "rails_helper"

RSpec.describe User, type: :model do
  it do
    is_expected.to(
      have_db_column(:email)
        .of_type(:string)
        .with_options(null: false)
    )
    is_expected.to(
      have_db_column(:encrypted_password)
        .of_type(:string)
        .with_options(null: false)
    )
    is_expected.to(
      have_db_column(:reset_password_token)
        .of_type(:string)
    )
    is_expected.to(
      have_db_column(:reset_password_sent_at)
        .of_type(:datetime)
    )
    is_expected.to(
      have_db_column(:remember_created_at)
        .of_type(:datetime)
    )
    is_expected.to(
      have_db_column(:sign_in_count)
        .of_type(:integer)
        .with_options(null: false, default: 0)
    )
    is_expected.to(
      have_db_column(:current_sign_in_at)
        .of_type(:datetime)
    )
    is_expected.to(
      have_db_column(:last_sign_in_at).of_type(:datetime)
    )
    is_expected.to(
      have_db_column(:current_sign_in_ip).of_type(:string)
    )
    is_expected.to(
      have_db_column(:last_sign_in_ip).of_type(:string)
    )
    is_expected.to(
      have_db_column(:created_at).of_type(:datetime).with_options(null: false)
    )
    is_expected.to(
      have_db_column(:updated_at).of_type(:datetime).with_options(null: false)
    )
    is_expected.to(have_db_index(:email).unique(true))
    is_expected.to(have_db_index(:reset_password_token).unique(true))
  end
end
