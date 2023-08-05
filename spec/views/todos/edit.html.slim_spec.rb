# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'todos/edit' do
  let(:todo) do
    Todo.create!(
      title:       'MyString',
      description: 'MyString'
    )
  end

  before do
    assign(:todo, todo)
  end

  it 'renders the edit todo form' do
    render

    assert_select 'form[action=?][method=?]', todo_path(todo), 'post' do
      assert_select 'input[name=?]', 'todo[title]'

      assert_select 'input[name=?]', 'todo[description]'
    end
  end
end
