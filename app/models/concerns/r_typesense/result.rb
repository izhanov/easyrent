# frozen_string_literal: true

module RTypesense
  class Result
    attr_reader :result

    def initialize(result)
      @result = result
    end

    def found
      @result["found"]
    end

    def pluck(*fields)
      if fields.size == 1
        @result["hits"].map do |hit|
          hit["document"].detect { |k, _| k == fields.last.to_s }.last
        end
      else
        @result["hits"].map do |hit|
          fields.map do |field|
            hit["document"].detect { |k, _| k == field.to_s }.last
          end.flatten
        end
      end
    end
  end
end
