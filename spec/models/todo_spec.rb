# frozen_string_literal: true

RSpec.describe Todo do
  let(:todo) { build(:complete_todo) }

  describe '.attributes' do
    describe 'name' do
      specify('name') { expect(todo.name).to eq('Name Value') }

      it 'is required' do
        todo.name = nil
        expect(todo).not_to be_valid
      end
    end

    specify('description') { expect(todo.description).to eq('Description Value') }
    specify('position') { expect(todo.position).to eq(42) }
  end
end
