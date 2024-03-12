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

    describe 'position' do
      let!(:todo) { create(:todo) }

      it 'defines the order position of the Todo' do
        expect(todo.position).to eq(1)
      end

      it 'defaults to the last position' do
        create(:another_todo)
        expect(described_class.pluck(:id, :position))
          .to contain_exactly([1, 1], [2, 2])
      end
    end

    specify('description') { expect(todo.description).to eq('Description Value') }
  end
end
