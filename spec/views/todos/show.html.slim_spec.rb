# frozen_string_literal: true

RSpec.describe 'todos/show' do
  before { assign :todo, create(:complete_todo) }

  it 'renders attributes' do
    render
    expect(rendered).to match(/Name Value/) # #name
    expect(rendered).to match(/Description Value/) # #description
    expect(rendered).to match(/42/) # #position
  end
end
