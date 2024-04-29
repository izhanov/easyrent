# frozen_string_literal: true

module ArelHelpers
  module Bookings
    extend ActiveSupport::Concern

    class_methods do
      # functions
      def abs_function(expr)
        Arel::Nodes::NamedFunction.new("ABS", [expr])
      end

      def extract_epoch_from_function(expr)
        Arel::Nodes::NamedFunction.new("EXTRACT", [Arel.sql("EPOCH FROM #{expr.to_sql}")])
      end

      def subtraction_function(left, right)
        Arel::Nodes::Subtraction.new(left, right)
      end

      def now_function
        Arel::Nodes::NamedFunction.new("NOW", [])
      end

      def date_function(column)
        Arel::Nodes::NamedFunction.new("DATE", [column])
      end

      # order by
      def by_nearest_to_now_order(column)
        abs_function(extract_epoch_from_function(subtraction_function(column, now_function)))
      end
    end
  end
end
