# frozen_string_literal: true

RSpec.describe 'todos/edit' do
  let(:todo) { create(:complete_todo) }

  before { assign(:todo, todo) }

  it 'renders new todo form' do
    render

    assert_select 'form[action=?][method=?]', todo_path(todo), 'post' do
      assert_select 'input[name=?]', 'todo[name]'
      assert_select 'textarea[name=?]', 'todo[description]'
    end
  end
end
