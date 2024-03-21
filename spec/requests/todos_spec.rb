# frozen_string_literal: true

RSpec.describe '/todos' do
  context 'with a valid existing record' do
    let!(:todo) { create(:complete_todo) }

    describe 'GET /index' do
      it 'renders a successful response' do
        get todos_url
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'renders a successful response' do
        get edit_todo_url(todo)
        expect(response).to be_successful
      end
    end

    describe 'PATCH /update' do
      context 'with valid update attributes' do
        let(:valid_attributes) { attributes_for(:another_todo) }

        it 'updates the requested todo' do
          patch todo_url(todo), params: { todo: valid_attributes }
          todo.reload
          attributes = todo.slice(valid_attributes.keys).symbolize_keys

          expect(attributes).to eq(valid_attributes)
        end
      end

      context 'with invalid update attributes' do
        let(:invalid_attributes) { attributes_for(:invalid_todo) }

        it 'Does not change the object' do
          patch todo_url(todo), params: { todo: invalid_attributes }

          actual_attributes = todo.reload.attributes.stringify_keys
          not_expected_attributes = invalid_attributes.stringify_keys

          expect(actual_attributes).not_to be >= not_expected_attributes
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested todo' do
        expect do
          delete todo_url(todo)
        end.to change(Todo, :count).by(-1)
      end
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_todo_url
      expect(response).to be_successful
    end
  end

  context 'with a valid new object' do
    let(:valid_attributes) { attributes_for(:complete_todo) }

    describe 'POST /create' do
      it 'creates a new Todo' do
        expect do
          post todos_url, params: { todo: valid_attributes }
        end.to change(Todo, :count).by(1)
      end
    end
  end

  context 'with an invalid new object' do
    let(:invalid_attributes) { attributes_for(:invalid_todo) }

    describe 'POST /create' do
      it 'does not create a new Todo' do
        expect do
          post todos_url, params: { todo: invalid_attributes }
        end.not_to change(Todo, :count)
      end
    end
  end
end
