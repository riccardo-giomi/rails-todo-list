# frozen_string_literal: true

<%
module_namespacing do
-%>
RSpec.describe <%= class_name %> do
  let(:<%= singular_name %>) { build(:complete_<%= singular_name %>) }
<%
  normal_attributes = attributes.reject { |attr| attr.attachment? || attr.attachments? }
  if normal_attributes.present?
-%>

  describe '.attributes' do
<%
    normal_attributes.each do |attribute|
      if attribute.extended_type == :title
-%>
    describe '<%= attribute.name %>' do
      specify('<%= attribute.name %>') { expect(<%= singular_name %>.<%= attribute.name %>).to eq(<%= attribute.factory_value.inspect %>) }

      it 'is required' do
        <%= singular_name%>.<%= attribute.name %> = nil
        expect(<%= singular_name%>).not_to be_valid
      end
    end
<%
      else
        matcher_name = case attribute.type
                      when :datetime, :timestamp
                        'be_the_same_datetime'
                      when :date
                        'be_the_same_date'
                      when :time
                        'be_the_same_time'
                      else
                        'eq'
                      end
-%>
    specify('<%= attribute.name %>') { expect(<%= singular_name %>.<%= attribute.name %>).to <%= matcher_name %>(<%= attribute.factory_value.inspect %>) }
<%
      end
    end
-%>
  end
<%
  end

  attachment_attributes = attributes.select { |attr| attr.attachment? || attr.attachments? }
  if attachment_attributes.present?
-%>

  describe 'attachments' do
<%
    attachment_attributes.each do |attribute|
-%>

    describe '#<%= attribute.name %>' do
<%
      if attribute.extended_type.in? [:image, :images]
-%>
      let(:variants) { described_class.reflect_on_attachment(:<%= attribute.name %>).named_variants.keys }
<%
      end
      if attribute.attachment?
-%>
      # Note that it still responds to #attachments with a single-value array
      it 'is a single-file attachment' do
        expect(<%= singular_name %>.<%= attribute.name %>).to respond_to(:attachment)
      end
<%
      else
-%>
      # The double expectations is there because single attachments also respond
      # to #attachments
      it 'is a multi-file attachment' do
        expect(<%= singular_name %>.<%= attribute.name %>)
          .to respond_to(:attachments)
          .and not_to_respond_to(:attachment)
      end
<%
      end
      if attribute.extended_type.in? [:image, :images]
-%>

      it 'has a "gallery" variant' do
        expect(variants).to include(:gallery)
      end

      it 'has a "thumb" variant' do
        expect(variants).to include(:thumb)
      end
<%
      end
-%>

      # Additional spec for images that are validated as required.
      # it 'is required' do
      #   expect(<%= singular_name %>).to validate_attached_of(:<%= attribute.name %>)
      # end

      it 'must be a valid image file' do
        expect(<%= singular_name %>).to validate_content_type_of(:<%= attribute.name %>).allowing(:jpg, :jpeg, :png)
      end

      # Additional spec for images that have a size validation (1MB in this example).
      # it 'must be of the right size (<= 1MB)' do
      #   expect(<%= singular_name %>).to validate_size_of(:<%= attribute.name %>).less_than_or_equal_to(1.megabyte)
      # end
    end
<%
    end
-%>
  end
<%
  end
-%>
end
<%
end
-%>
