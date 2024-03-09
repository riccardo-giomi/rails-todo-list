# frozen_string_literal: true

RSpec.describe '<%= ns_table_name %>/edit' do
  let(:<%= singular_table_name %>) { create(:complete_<%= singular_table_name %>) }
  before { assign(:<%= singular_table_name %>, <%= singular_table_name %>) }

  it 'renders new <%= ns_file_name %> form' do
    render

<%
if attributes.find { _1.attachment? || _1.attachments? }
-%>
    assert_select 'form[action=?][method=?][enctype=?]', <%= ns_file_name %>_path(<%= singular_table_name %>), 'post', 'multipart/form-data' do
<%
else
-%>
    assert_select 'form[action=?][method=?]', <%= ns_file_name %>_path(<%= singular_table_name %>), 'post' do
<%
end

for attribute in attributes
  name = attribute.respond_to?(:column_name) ? attribute.column_name : attribute.name

  if attribute.attachment?
-%>
      # Single file attachment "<%= name %>"
      # To add or replace the file
      assert_select 'input[name=?][type=?]', '<%= ns_file_name %>[<%= name %>]', 'file'
      # To remove the file
      assert_select 'input[name=?][type=?]', '<%= ns_file_name %>[<%= name %>]', 'checkbox'

<%
  elsif attribute.attachments?
-%>

      # Multi-file attachments "<%= name %>"
      # To add new files
      assert_select 'input[name=?][type=?][multiple]', '<%= ns_file_name %>[<%= name %>][]', 'file'
      # To remove files
      assert_select 'input[name=?][type=?]', '<%= ns_file_name %>[<%= name %>][]', 'checkbox'

<%
  elsif attribute.type == :boolean
-%>
      assert_select 'input[name=?][type=hidden]', '<%= ns_file_name %>[<%= name %>]'
      assert_select 'input[name=?][type=checkbox]', '<%= ns_file_name %>[<%= name %>]'
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
