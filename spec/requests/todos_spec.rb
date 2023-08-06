# frozen_string_literal: true

# rubocop:disable RSpec/NestedGroups
RSpec.describe '/todos' do
  let(:valid_attributes) do
    { title: 'I am a To Do thing.', description: 'It is indeed a To Do thing now.' }
  end

  let(:invalid_attributes) do
    { title: '' }
  end

  context 'when serving HTML Requests' do
    it 'does not respond to GET /show' do
      todo = Todo.create! valid_attributes
      expect { get todo_path(todo) }.to raise_error(ActionController::RoutingError)
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        get todos_path
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_todo_path
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      it 'creates a new Todo' do
        expect do
          post todos_path, params: { todo: valid_attributes }
        end.to change(Todo, :count).by(1)

        expect(response).to redirect_to(todos_path)
      end

      it 'does not create a new Todo if the parameters are invalid' do
        expect do
          post todos_path, params: { todo: invalid_attributes }
        end.not_to change(Todo, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    describe 'GET /edit' do
      it 'renders a successful response' do
        todo = Todo.create! valid_attributes
        get edit_todo_path(todo)
        expect(response).to be_successful
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:new_attributes) do
          {
            title:       'I changed my mind and do something different',
            description: 'The description changed too!'
          }
        end

        it 'updates the requested todo' do
          todo = Todo.create! valid_attributes
          patch todo_path(todo), params: { todo: new_attributes }
          todo.reload
          expect(todo.slice(:title, :description)).to eq(new_attributes.stringify_keys!)
        end

        it 'redirects to the todo' do
          todo = Todo.create! valid_attributes
          patch todo_path(todo), params: { todo: new_attributes }
          todo.reload
          expect(response).to redirect_to(todos_path)
        end
      end

      context 'with invalid parameters' do
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          todo = Todo.create! valid_attributes
          patch todo_path(todo), params: { todo: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested todo' do
        todo = Todo.create! valid_attributes
        expect do
          delete todo_path(todo)
        end.to change(Todo, :count).by(-1)
      end

      it 'redirects to the todos list' do
        todo = Todo.create! valid_attributes
        delete todo_path(todo)
        expect(response).to redirect_to(todos_path)
      end
    end
  end

  context 'when serving Turbo Stream Requests' do
    let(:headers) do
      { accept: 'text/vnd.turbo-stream.html' }
    end

    describe 'POST /create' do
      it 'creates a new Todo' do
        expect do
          post(todos_path, params: { todo: valid_attributes }, headers:)
        end.to change(Todo, :count).by(1)

        expect(response).to be_successful
        expect(response.content_type).to match(/turbo-stream/)
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested todo' do
        todo = Todo.create! valid_attributes
        expect do
          delete(todo_path(todo), headers:)
        end.to change(Todo, :count).by(-1)

        expect(response).to be_successful
        expect(response.content_type).to match(/turbo-stream/)
      end
    end
  end

  context 'when serving JSON Requests' do
    let(:headers) do
      { accept: 'application/json', content_type: 'application/json' }
    end

    describe 'GET /show' do
      it 'returns a successful response' do
        todo = create(:todo)
        get(todo_path(todo), headers:)

        expect(response).to be_successful
        expect(response.content_type).to match(/json/)
      end
    end
  end
end
# rubocop:enable RSpec/NestedGroups
