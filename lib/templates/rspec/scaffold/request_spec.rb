# frozen_string_literal: true

<%
module_namespacing do
-%>
RSpec.describe '/<%= name.underscore.pluralize %>' do
<%
  if mountable_engine?
-%>
    include Engine.routes.url_helpers

<%
  end
-%>
  context 'with a valid existing record' do
    let!(:<%= name.underscore %>) { create(:complete_<%= name.underscore%>) }
<%
  unless options[:singleton]
-%>

    describe 'GET /index' do
      it 'renders a successful response' do
        get <%= index_helper %>_url
        expect(response).to be_successful
      end
    end
<%
  end
-%>

    describe 'GET /show' do
      it 'renders a successful response' do
        get <%= show_helper %>
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'renders a successful response' do
        get <%= edit_helper %>
        expect(response).to be_successful
      end
    end

    describe 'PATCH /update' do
      context 'with valid update attributes' do
        let(:valid_attributes) { attributes_for(:another_<%= name.underscore%>) }

        it 'updates the requested <%= singular_table_name %>' do
          patch <%= show_helper %>, params: { <%= singular_table_name %>: valid_attributes }
          <%= file_name %>.reload
          attributes = <%= file_name %>.slice(valid_attributes.keys).symbolize_keys

          expect(attributes).to eq(valid_attributes)
        end

        it 'redirects to the <%= singular_table_name %>' do
          patch <%= show_helper %>, params: { <%= singular_table_name %>: valid_attributes }
          <%= file_name %>.reload
          expect(response).to redirect_to(<%= singular_table_name %>_url(<%= file_name %>))
        end
      end

      context 'with invalid update attributes' do
        let(:invalid_attributes) { attributes_for(:invalid_<%= name.underscore%>) }
<%
  unless attributes.any? { _1.extended_type == :title }
-%>
        # Simulates an invalid model even if there is no such constraint currently
        # in the model.
        #
        # Remove when such a constraint is defined and the
        # :invalid_<%= name.underscore %> factory is updated.
        before do
          expect_any_instance_of(class_name).to receive(:valid?).at_least(:once).and_return(false)
        end

<%
  end
-%>
        it 'renders a response with 422 status (i.e. to display the "edit" template)' do
          patch <%= show_helper %>, params: { <%= singular_table_name %>: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested <%= singular_table_name %>' do
        expect do
          delete <%= show_helper %>
        end.to change(<%= class_name %>, :count).by(-1)
      end

      it 'redirects to the <%= table_name %> list' do
        delete <%= show_helper %>
        expect(response).to redirect_to(<%= index_helper %>_url)
      end
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get <%= new_helper %>
      expect(response).to be_successful
    end
  end

  context 'with a valid new object' do
    let(:valid_attributes) { attributes_for(:complete_<%= name.underscore%>) }

    describe 'POST /create' do
      it 'creates a new <%= class_name %>' do
        expect do
          post <%= index_helper %>_url, params: { <%= singular_table_name %>: valid_attributes }
        end.to change(<%= class_name %>, :count).by(1)
      end

      it 'redirects to the created <%= singular_table_name %>' do
        post <%= index_helper %>_url, params: { <%= singular_table_name %>: valid_attributes }
        expect(response).to redirect_to(<%= show_helper("#{class_name}.last") %>)
      end
    end
  end

  context 'with an invalid new object' do
    let(:invalid_attributes) { attributes_for(:invalid_<%= name.underscore%>) }

    describe 'POST /create' do
<%
  unless attributes.any? { _1.extended_type == :title }
-%>

      # Simulates an invalid model even if there is no such constraint currently
      # in the model.
      #
      # Remove when such a constraint is defined and the
      # :invalid_<%= name.underscore %> factory is updated.
      before do
        expect_any_instance_of(class_name)
        .to receive(:valid?).at_least(:once)
        .and_return(false)
      end
<%
  end
-%>

      it 'does not create a new <%= class_name %>' do
        expect do
          post <%= index_helper %>_url, params: { <%= singular_table_name %>: invalid_attributes }
        end.to change(<%= class_name %>, :count).by(0)
      end

      it 'renders a response with 422 status (i.e. to display the "new" template)' do
        post <%= index_helper %>_url, params: { <%= singular_table_name %>: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
<%
end
-%>
