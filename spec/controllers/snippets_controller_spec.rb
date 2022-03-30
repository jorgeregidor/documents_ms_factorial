# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do
  before(:each) do
    Account.destroy_all
    Snippet.destroy_all
    @account = build(:account)
    @snippet = build(:snippet)
  end

  describe 'GET index' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      get :index
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 200' do
      @account.save
      sni = @account.snippets.new(@snippet.attributes)
      sni.save
      request.headers['User-Info'] = user_info_payload
      get :index
      expect(response).to have_http_status(:ok)
      expect(@account.snippets.all.size).to eq(1)
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
      @account.save
      sni = @account.snippets.new(@snippet.attributes)
      sni.save
      request.headers['User-Info'] = user_info_payload

      get :show, params: { id: sni.uuid }
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

      post :create, params: create_snippet_payload
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH update' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      patch :update, params: { id: '0' }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 400' do
      @account.save
      sni = @account.snippets.new(@snippet.attributes)
      sni.save
      request.headers['User-Info'] = user_info_payload
      patch :update, params: { id: sni.uuid }
      expect(response).to have_http_status(400)
    end

    it 'returns 404' do
      request.headers['User-Info'] = user_info_payload
      patch :update, params: { id: '0' }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a ok' do
      @account.save
      sni = @account.snippets.new(@snippet.attributes)
      sni.save
      request.headers['User-Info'] = user_info_payload

      patch :update, params: update_snippet_payload(sni.uuid)
      expect(response).to have_http_status(:ok)
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
      @account.save
      sni = @account.snippets.new(@snippet.attributes)
      sni.save
      request.headers['User-Info'] = user_info_payload

      delete :destroy, params: { id: sni.uuid }
      expect(response).to have_http_status(204)
    end
  end
end
