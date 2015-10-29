require 'rails_helper'

describe ContactsController do
  let!(:contacts) { create_list(:contact, 2) }

  describe 'GET index' do
    before { get :index }

    it 'correct response code, template and instance' do
      expect(response).to be_success
      expect(response).to render_template(:index)
      expect(assigns(:contacts)).to eq(contacts)
    end
  end

  describe 'GET show' do
    before { get :show, id: contacts.first }

    it 'correct response code, template and instance' do
      expect(response).to be_success
      expect(response).to render_template(:show)
      expect(assigns(:contact)).to eq(contacts.first)
    end
  end

  describe 'GET new' do
    before { get :new }

    it 'correct response code, template and instance' do
      expect(response).to be_success
      expect(response).to render_template(:new)
      expect(assigns(:contact).id).to be_nil
    end
  end

  describe 'GET edit' do
    before { get :edit, id: contacts.first }

    it 'correct response code, template and instance' do
      expect(response).to be_success
      expect(response).to render_template(:edit)
      expect(assigns(:contact)).to eq(contacts.first)
    end
  end

  describe 'POST create' do
    let!(:wrong_params) { { first_name: 'wrong', last_name: '' } }
    before { post :create, params: wrong_params }

    context 'when wrong params' do
      it 'render new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    before { delete :destroy, id: contacts.last }

    it 'redirect to index' do
      expect(response).to redirect_to(contacts_path)
    end
  end
end