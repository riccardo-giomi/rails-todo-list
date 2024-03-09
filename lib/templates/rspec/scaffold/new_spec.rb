# frozen_string_literal: true

RSpec.describe '<%= ns_table_name %>/new' do
  before { assign(:<%= singular_table_name %>, <%= class_name %>.new) }

  it 'renders new <%= ns_file_name %> form' do
    render

<%
if attributes.find { _1.attachment? || _1.attachments? }
-%>
    assert_select 'form[action=?][method=?][enctype=?]', <%= index_helper %>_path, 'post', 'multipart/form-data' do
<%
else
-%>
    assert_select 'form[action=?][method=?]', <%= index_helper %>_path, 'post' do
<%
end

for attribute in attributes
  name = attribute.respond_to?(:column_name) ? attribute.column_name : attribute.name

  if attribute.attachment?
-%>
      assert_select '<%= attribute.input_type -%>[name=?][type=?]', '<%= ns_file_name %>[<%= name %>]', 'file'
<%
  elsif attribute.attachments?
-%>
      assert_select '<%= attribute.input_type -%>[name=?][type=?][multiple]', '<%= ns_file_name %>[<%= name %>][]', 'file'
<%
  else
-%>
      assert_select '<%= attribute.input_type -%>[name=?]', '<%= ns_file_name %>[<%= name %>]'
<%
  end
end
-%>
    end
  end
end
