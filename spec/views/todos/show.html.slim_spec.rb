# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'todos/show' do
  before do
    assign(:todo, Todo.create!(
                    title:       'Title',
                    description: 'Description'
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
  end
end
