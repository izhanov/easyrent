# frozen_string_literal: true

# == Schema Information
#
# Table name: photos
#
#  id         :bigint           not null, primary key
#  image_data :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  car_id     :bigint           not null
#
# Indexes
#
#  index_photos_on_car_id  (car_id)
#
# Foreign Keys
#
#  fk_rails_dace6a373c  (car_id => cars.id)
#
class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :car
end
