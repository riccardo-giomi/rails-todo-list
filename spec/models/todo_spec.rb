# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo do
  it 'requires a title' do
    todo = described_class.new
    todo.valid?
    expect(todo.errors[:title]).to match(a_collection_including(/blank/))
  end
end
