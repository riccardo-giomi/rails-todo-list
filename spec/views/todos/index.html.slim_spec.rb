# frozen_string_literal: true

RSpec.describe 'todos/index' do
  let(:todos) { create_list(:complete_todo, 2) }

  before { assign(:todos, todos) }

  it 'renders a list of todos' do
    render

    todos.each do |todo|
      assert_select "#todos div##{dom_id todo}" do
        assert_select 'div', text: Regexp.new('Name Value')
        assert_select 'div', text: Regexp.new('Description Value')
        assert_select 'div', text: Regexp.new('42')
      end
    end
  end
end
