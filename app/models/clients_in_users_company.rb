# frozen_string_literal: true

# == Schema Information
#
# Table name: clients_in_users_companies
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_clients_in_users_companies_on_client_id  (client_id)
#  index_clients_in_users_companies_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_70198f1b41  (user_id => users.id)
#  fk_rails_d38ab75075  (client_id => clients.id)
#
class ClientsInUsersCompany < ApplicationRecord
  belongs_to :user
  belongs_to :client
end
