# frozen_string_literal: true

require "image_processing/vips"

class ImageUploader < Shrine
  Attacher.derivatives do |original|
    vips = ImageProcessing::Vips.source(original).convert("webp")

    {
      large: vips.resize_to_limit!(800, 800),
      medium: vips.resize_to_limit!(500, 500),
      small: vips.resize_to_limit!(100, 100)
    }
  end
end
