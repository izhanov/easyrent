# frozen_string_literal: true

module RTypesense
  class Field
    attr_reader :name, :type, :options, :nested_fields
    attr_accessor :parent

    def initialize(name, type, options = {})
      @name = name
      @type = type
      @options = options
      @parent = nil
      @nested_fields = []
    end

    def add(field)
      field.parent = self
      @nested_fields << field
      self
    end

    def parent?
      @parent ? false : true
    end

    def child?
      @parent ? true : false
    end

    def string?
      type == "string"
    end

    def object?
      type == "object"
    end

    def array_of_object?
      type == "object[]"
    end
  end
end
