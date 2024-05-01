# frozen_string_literal: true

module RTypesense
  def self.included(receiver)
    receiver.extend ClassMethods
  end

  module ClassMethods
    attr_reader :typesense_schema

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
      define_field(field_name, "string", **options)
    end

    def int32(field_name, options = {})
      define_field(field_name, "int32", **options)
    end

    def array_of_string(field_name, options = {}, &block)
      @typesense_schema[:enable_nested_fields] = true
      object_field = define_field(field_name, "string[]", **options)
      yield(object_field) if block
    end

    def object(class_name, options = {}, &block)
      @typesense_schema[:enable_nested_fields] = true
      object_field = define_field(class_name, "object", **options)
      yield(object_field) if block
    end

    def array_of_object(resource, options = {}, &block)
      @typesense_schema[:enable_nested_fields] = true
      object_field = define_field(resource, "object[]", **options)
      yield(object_field) if block
    end

    def define_field(field_names, type, options = {})
      if field_names.is_a?(Array)
        field_one, field_two = field_names
        if field_one.is_a?(Field)
          nested_field = Field.new(field_two, type, **options)
          nested_field.parent = field_one
          field_one.add(nested_field)
          nested_field
        end
      else
        field = Field.new(field_names, type, **options)
        @typesense_schema[:fields] << field
        field
      end
    end

    def as_typesense_document(record)
      typesense_schema_fields = typesense_schema[:fields]
      typesense_schema_fields.each_with_object({}) do |field, document|
        if field.object?
          object = record.send(field.name)
          document[field.name] = nested_document(object, field.nested_fields)
        elsif field.array_of_object?
          objects = record.send(field.name)
          document[field.name] = objects.map do |object|
            nested_document(object, field.nested_fields)
          end
        elsif field.array_of_string?
          objects = record.send(field.name)
          document[field.name] = if objects.is_a?(Array)
            objects
          elsif objects.all? { |object| object.is_a?(ApplicationRecord) }
            objects.map do |object|
              nested_array(object, field.nested_fields)
            end.flatten
          end
        else
          document[field.name] = type_cast(record.send(field.name), field.type)
        end
      end
    end

    def nested_document(object, nested_fields)
      nested_fields.each_with_object({}) do |nested_field, nested_document|
        nested_document[nested_field.name] = if nested_field.object?
          nested_document(object.send(nested_field.name), nested_field.nested_fields)
        else
          type_cast(object.send(nested_field.name), nested_field.type)
        end
      end
    end

    def nested_array(object, nested_fields)
      nested_fields.each_with_object([]) do |nested_field, nested_array|
        nested_array << type_cast(object.send(nested_field.name), nested_field.type)
      end
    end

    def typesense_upsert(record)
      typesense_client.collections[typesense_schema[:name]]
        .documents.upsert(as_typesense_document(record))
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
      schema = typesense_schema.each_with_object({}) do |(key, values), schema|
        schema[key] = case key
        when :fields
          values.map do |field|
            if field.object?
              if field.nested_fields.present?
                field.nested_fields.map do |nested_field|
                  if nested_field.object?
                    nested_field.nested_fields.map do |deep_nested_field|
                      {name: "#{field.name}.#{nested_field.name}.#{deep_nested_field.name}", type: deep_nested_field.type, **deep_nested_field.options}
                    end
                  else
                    {name: "#{field.name}.#{nested_field.name}", type: nested_field.type, **nested_field.options}
                  end
                end
              else
                {name: field.name, type: field.type, **field.options}
              end
            else
              {name: field.name, type: field.type, **field.options}
            end
          end.flatten
        else
          values
        end
      end
      typesense_client.collections.create(schema)
    end

    def collection_delete!
      typesense_client.collections[typesense_schema[:name]].retrieve
      typesense_client.collections[typesense_schema[:name]].delete
    rescue Typesense::Error::ObjectNotFound
      nil
    end
  end
end
