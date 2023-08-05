# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'todos/index' do
  before do
    assign(:todos, [
             Todo.create!(
               title:       'Title',
               description: 'Description'
             ),
             Todo.create!(
               title:       'Title',
               description: 'Description'
             )
           ])
  end

  it 'renders a list of todos' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Title'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Description'.to_s), count: 2
  end
end
