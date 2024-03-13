# frozen_string_literal: true

RSpec.describe 'todos/new' do
  before { assign(:todo, Todo.new) }

  it 'renders new todo form' do
    render

    assert_select 'form[action=?][method=?]', todos_path, 'post' do
      assert_select 'input[name=?]', 'todo[name]'
      assert_select 'textarea[name=?]', 'todo[description]'
    end
  end
end
