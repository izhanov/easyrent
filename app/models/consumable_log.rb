# == Schema Information
#
# Table name: consumable_logs
#
#  id                        :bigint           not null, primary key
#  date                      :date
#  description               :string
#  mileage_at_next_replacing :integer
#  mileage_when_replacing    :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  consumable_id             :bigint           not null
#
# Indexes
#
#  index_consumable_logs_on_consumable_id  (consumable_id)
#
# Foreign Keys
#
#  fk_rails_8619ae8c72  (consumable_id => consumables.id)
#
class ConsumableLog < ApplicationRecord
  belongs_to :consumable

  audited
end
