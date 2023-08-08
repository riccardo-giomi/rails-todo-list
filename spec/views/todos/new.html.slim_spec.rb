# frozen_string_literal: true

RSpec.describe 'todos/new' do
  before do
    assign(:todo, Todo.new(
                    title:       'MyString',
                    description: 'MyString'
                  ))
  end

  it 'renders new todo form' do
    render

    assert_select 'form[action=?][method=?]', todos_path, 'post' do
      assert_select 'input[name=?]', 'todo[title]'

      assert_select 'textarea[name=?]', 'todo[description]'
    end
  end
end
