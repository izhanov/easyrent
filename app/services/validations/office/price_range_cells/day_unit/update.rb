# frozen_string_literal: true

module Validations
  module Office
    module PriceRangeCells
      module DayUnit
        class Update < Base
          option :price_range

          params do
            required(:from).filled(:integer)
            required(:to).filled(:integer)
          end

          rule(:from, :to) do
            unless values[:from] < values[:to]
              key(price_range: :price_range_cell).failure(:from_greater_than_to)
            end

            if values[:from].eql?(values[:to])
              key(price_range: :price_range_cell).failure(:from_and_to_equal)
            end
          end

          rule(:from, :to) do
            exist_total_days = price_range.price_range_cells.sum { |cell| (cell.from..cell.to).count }
            extra_days = (values[:from]..values[:to]).count

            if exist_total_days + extra_days > 30
              key(price_range: :price_range_cell).failure(:total_days_greater_than_30)
            end
          end

          rule(:from, :to) do
            last_cel = price_range.price_range_cells.order(to: :desc).first
            if last_cel.present? && last_cel.to == values[:from]
              key(price_range: :price_range_cell).failure(:from_equal_last_to)
            end
          end

          rule(:from) do
            if price_range.price_range_cells.detect { |cell| cell.from == value }.present?
              key(price_range: :price_range_cell).failure(:from_already_exist)
            end
          end
        end
      end
    end
  end
end
