# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  before(:each) do
    Account.destroy_all
    Document.destroy_all
    @account = build(:account)
    @document = build(:document)
  end

  describe 'GET index' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      get :index
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 200' do
      @document.save
      request.headers['User-Info'] = user_info_payload
      get :index
      expect(response).to have_http_status(:ok)
      expect(Document.all.size).to eq(1)
    end
  end

  describe 'GET show' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      get :show, params: { id: '0' }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns 404' do
      request.headers['User-Info'] = user_info_payload
      get :show, params: { id: '0' }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a ok' do
      @document.save
      request.headers['User-Info'] = user_info_payload

      get :show, params: { id: @document.uuid }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      post :create
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 400' do
      request.headers['User-Info'] = user_info_payload
      post :create
      expect(response).to have_http_status(400)
    end

    it 'returns a ok' do
      request.headers['User-Info'] = user_info_payload

      post :create, params: create_document_payload('name1')
      expect(response).to have_http_status(:created)
    end

    it 'returns a not ok' do
      request.headers['User-Info'] = user_info_payload

      post :create, params: create_document_payload(nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH update' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      patch :update, params: { id: '0' }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 400' do
      @document.save

      request.headers['User-Info'] = user_info_payload
      patch :update, params: { id: @document.uuid }
      expect(response).to have_http_status(400)
    end

    it 'returns 404' do
      request.headers['User-Info'] = user_info_payload
      patch :update, params: { id: '0' }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a ok' do
      @account.save
      doc = @account.documents.new(@document.attributes)
      doc.save
      request.headers['User-Info'] = user_info_payload

      patch :update, params: update_document_payload(doc.uuid, 'name2')
      expect(response).to have_http_status(:ok)
    end

    it 'returns a not ok' do
      @account.save
      doc = @account.documents.new(@document.attributes)
      doc.save
      request.headers['User-Info'] = user_info_payload

      patch :update, params: update_document_payload(doc.uuid, nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE destroy' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      delete :destroy, params: { id: '0' }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns 404' do
      request.headers['User-Info'] = user_info_payload
      delete :destroy, params: { id: '0' }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a 204' do
      @document.save
      request.headers['User-Info'] = user_info_payload

      delete :destroy, params: { id: @document.uuid }
      expect(response).to have_http_status(204)
    end
  end
end
