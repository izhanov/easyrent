# == Schema Information
#
# Table name: cars
#
#  id                           :bigint           not null, primary key
#  color                        :string
#  fuel                         :string
#  klass                        :string
#  mileage                      :string
#  number_of_seats              :string
#  ownerable_type               :string           not null
#  plate_number                 :string           not null
#  status                       :string
#  tank_volume                  :string
#  technical_certificate_number :string
#  transmission                 :string
#  vin_code                     :string           not null
#  year                         :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  mark_id                      :bigint           not null
#  ownerable_id                 :bigint           not null
#
# Indexes
#
#  index_cars_on_mark_id    (mark_id)
#  index_cars_on_ownerable  (ownerable_type,ownerable_id)
#
# Foreign Keys
#
#  fk_rails_77305b2b6f  (mark_id => marks.id)
#
class Car < ApplicationRecord
  belongs_to :mark
  belongs_to :ownerable, polymorphic: true

  # Requirements:
  # Typesense server running on localhost:8108
  # gem 'typesense'
  include RTypesense

  draw_schema do
    string :id, optional: false
    string :vin_code, optional: false, infix: true
    string :year, optional: true
    string :color, optional: true, infix: true
    string :status, optional: false, infix: true
    object :mark, optional: false do |object_name|
      string [object_name, :title], optional: false
      array_of_string [object_name, :synonyms], optional: true
      string [object_name, :body], optional: true, infix: true
    end
  end
end
