# frozen_string_literal: true

module RTypesense
  def self.included(receiver)
    receiver.extend ClassMethods
  end

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

  module ClassMethods
    attr_accessor :typesense_schema

    def typesense(query_options)
      result = typesense_client.collections[model_name.plural].documents.search(query_options)
      RTypesense::Result.new(result)
    end

    def index!
      collection_create!
      in_batches do |relation|
        relation.each do |record|
          typesense_client.collections[typesense_schema[:name]]
            .documents.upsert(as_typesense_document(record))
        end
      end
    end

    def reindex!
      collection_delete!
      index!
    end

    def draw_schema(name: model_name.plural, &block)
      @typesense_schema = {
        name: name,
        fields: []
      }

      yield if block
      @typesense_schema
    end

    def string(field_name, options = {})
      if field_name.is_a?(Array)
        nested_field = @typesense_schema[:fields].detect { |f| f[:name] == field_name.first }
        nested_field[:fields] << {name: field_name.last, type: "string", **options}
      else
        @typesense_schema[:fields] << {name: field_name, type: "string", **options}
      end
    end

    def int32(field_name, options = {})
      if field_name.is_a?(Array)
        nested_field = @typesense_schema[:fields].detect { |f| f[:name] == field_name.first }
        nested_field[:fields] << {name: field_name.last, type: "int32", **options}
      else
        @typesense_schema[:fields] << {name: field_name, type: "int32", **options}
      end
    end

    def array_of_string(field_name, options = {})
      if field_name.is_a?(Array)
        nested_field = @typesense_schema[:fields].detect { |f| f[:name] == field_name.first }
        nested_field[:fields] << {name: field_name.last, type: "string[]", **options}
      else
        @typesense_schema[:fields] << {name: field_name, type: "string[]", **options}
      end
    end

    def object(class_name, options = {}, &block)
      @typesense_schema[:enable_nested_fields] = true
      @typesense_schema[:fields] << {name: class_name, type: "object", **options, fields: []}
      yield(class_name) if block
    end

    def as_typesense_document(record)
      document = {}
      typesense_schema[:fields].each do |field|
        document[field[:name]] =
          if field[:type] == "object"
            field[:fields].each_with_object({}) do |nested_field, result|
              result[nested_field[:name]] =
                type_cast(record.send(field[:name]).send(nested_field[:name]), nested_field[:type])
            end
          else
            type_cast(record.send(field[:name]), field[:type])
          end
      end
      document
    end

    private

    def typesense_client
      @typesense_client ||= Typesense::Client.new(
        nodes: [
          {
            host: Rails.application.credentials.typesense.host,
            port: Rails.application.credentials.typesense.port,
            protocol: Rails.application.credentials.typesense.protocol
          }
        ],
        api_key: Rails.application.credentials.typesense.api_key,
        connection_timeout_seconds: Rails.application.credentials.typesense.connection_timeout_seconds
      )
    end

    def type_cast(value, type)
      case type
      when "int32"
        value.to_i
      when "string"
        value.to_s
      when "float"
        value.to_f
      else
        value
      end
    end

    def collection_create!
      typesense_client.collections[typesense_schema[:name]].retrieve
    rescue Typesense::Error::ObjectNotFound
      typesense_client.collections.create(typesense_schema)
    end

    def collection_delete!
      typesense_client.collections[typesense_schema[:name]].retrieve
      typesense_client.collections[typesense_schema[:name]].delete
    rescue Typesense::Error::ObjectNotFound
      nil
    end
  end
end
