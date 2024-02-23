require "rails_helper"

RSpec.describe ClientsInUsersCompany, type: :model do
  it do
    is_expected.to belong_to(:user)
    is_expected.to belong_to(:client)
  end
end
