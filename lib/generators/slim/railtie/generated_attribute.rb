# frozen_string_literal: true

module Rails
  module Generators
    # Rails class that handles how arguments from generator calls inform the templates used.
    # Rewritten to allow for additional types that
    class GeneratedAttribute
      attr_accessor :extended_attr_options

      def extended_type
        extended_attr_options[:type]
      end

      class << self
        alias original_parse parse

        def parse(*)
          attribute = original_parse(*)
          attribute.extended_attr_options = attribute.attr_options.delete(:extended) || {}
          attribute
        end

        private

        alias original_parse_type_and_options parse_type_and_options

        def parse_type_and_options(type) # rubocop:disable Metrics/MethodLength
          case type
          when 'title'
            ['string', { null: false, extended: { type: :title } }]
          when /title\{(\d+)\}/
            ['string', { limit: ::Regexp.last_match(2).to_i, null: false, extended: { type: :title } }]
          when 'abstract'
            ['text', { extended: { type: :abstract } }]
          when 'image'
            ['attachment', { extended: { type: type.to_sym } }]
          when 'images'
            ['attachments', { extended: { type: type.to_sym } }]
          when 'boolean'
            # Because RuboCop told me so, false should be a reasonable default
            [type, { null: false, default: false }]
          else
            original_parse_type_and_options(type)
          end
        end
      end

      def factory_value(alternative: false) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity
        @factory_value ||= case type
                           when :string, :text
                             "#{alternative ? 'Another ' : ''}#{name.humanize} Value"
                           when :integer
                             alternative ? 24 : 42
                           when :float
                             alternative ? 73.31 : 13.37
                           when :decimal
                             alternative ? '73.31' : '13.37'
                           when :datetime, :timestamp
                             alternative ? '2023-11-17 04:21:11' : '2024-01-21 13:37:33'
                           when :date
                             alternative ? '2024-01-25' : '2024-02-01'
                           when :time
                             alternative ? '12:40:51' : '06:33:00'
                           when :boolean
                             !alternative
                           when :references, :belongs_to,
                                :attachment, :attachments,
                                :rich_text
                             nil
                           else
                             ''
                           end
      end
    end
  end
end
