# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :marks, dependent: :destroy
end
