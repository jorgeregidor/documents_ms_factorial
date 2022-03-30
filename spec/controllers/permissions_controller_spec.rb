# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PermissionsController, type: :controller do
  before(:each) do
    Account.destroy_all
    Document.destroy_all
    Permission.destroy_all
    @account = build(:account)
    @document = build(:document)
    @permission = build(:permission)
  end

  describe 'GET index' do
    it 'returns a forbidden' do
      @document.save
      request.headers['User-Info'] = {}
      get :index, params: { document_id: @document.uuid }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 200' do
      @document.save
      per = @document.permissions.new(@permission.attributes)
      per.save
      request.headers['User-Info'] = user_info_payload
      get :index, params: { document_id: @document.uuid }
      expect(response).to have_http_status(:ok)
      expect(@document.permissions.size).to eq(1)
    end

    it 'returns a unprocessable_entity' do
      request.headers['User-Info'] = user_info_payload
      get :index, params: { document_id: 0 }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET show' do
    it 'returns a forbidden' do
      @document.save
      request.headers['User-Info'] = {}
      get :show, params: { document_id: @document.uuid, id: '0' }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns 404' do
      @document.save
      request.headers['User-Info'] = user_info_payload
      get :show, params: { document_id: @document.uuid, id: '0' }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error' do
      request.headers['User-Info'] = user_info_payload
      get :show, params: { document_id: 0, id: '0' }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a ok' do
      @document.save
      per = @document.permissions.new(@permission.attributes)
      per.save
      request.headers['User-Info'] = user_info_payload

      get :show, params: { document_id: @document.uuid, id: per.uuid }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    it 'returns a forbidden' do
      @document.save
      request.headers['User-Info'] = {}
      post :create, params: { document_id: @document.uuid }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 400' do
      @document.save
      request.headers['User-Info'] = user_info_payload
      post :create, params: { document_id: @document.uuid }
      expect(response).to have_http_status(400)
    end

    it 'returns error' do
      request.headers['User-Info'] = user_info_payload
      get :show, params: { document_id: 0, id: '0' }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a ok' do
      @document.save
      request.headers['User-Info'] = user_info_payload

      post :create, params: create_permission_payload(@document.uuid, '1234')
      expect(response).to have_http_status(:created)
    end

    it 'returns a not ok' do
      @document.save
      per = @document.permissions.new(@permission.attributes)
      per.save
      request.headers['User-Info'] = user_info_payload
      post :create, params: create_permission_payload(@document.uuid, per.user_id)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH update' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      patch :update, params: { document_id: 0, id: 0 }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns a 400' do
      @document.save
      per = @document.permissions.new(@permission.attributes)
      per.save
      request.headers['User-Info'] = user_info_payload
      patch :update, params: { document_id: @document.uuid, id: per.uuid }
      expect(response).to have_http_status(400)
    end

    it 'returns 404' do
      @document.save
      request.headers['User-Info'] = user_info_payload
      patch :update, params: { document_id: @document.uuid, id: 0 }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error' do
      request.headers['User-Info'] = user_info_payload
      patch :update, params: { document_id: 0, id: 0 }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a ok' do
      @document.save
      per = @document.permissions.new(@permission.attributes)
      per.save
      request.headers['User-Info'] = user_info_payload

      patch :update, params: update_permission_payload(@document.uuid, per.uuid, '1234')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE destroy' do
    it 'returns a forbidden' do
      request.headers['User-Info'] = {}
      delete :destroy, params: { document_id: 0, id: 0 }
      expect(response).to have_http_status(:forbidden)
    end

    it 'returns 404' do
      @document.save
      request.headers['User-Info'] = user_info_payload
      delete :destroy, params: { document_id: @document.uuid, id: '0' }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns error' do
      request.headers['User-Info'] = user_info_payload
      delete :destroy, params: { document_id: '0', id: '0' }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a 204' do
      @document.save
      per = @document.permissions.new(@permission.attributes)
      per.save
      request.headers['User-Info'] = user_info_payload

      delete :destroy, params: { document_id: @document.uuid, id: per.uuid }
      expect(response).to have_http_status(204)
    end
  end
end
