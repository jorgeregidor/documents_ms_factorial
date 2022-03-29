# frozen_string_literal: true

# Handle Epic endpoints
class DocumentsController < ApplicationController
  before_action :set_document,         except: %i[index create]
  before_action :set_account,          only: %i[create]
  after_action  :verify_authorized,    except: %i[index]
  after_action  :verify_policy_scoped, only:   %i[index]

  def index
    authorize(Document)
    @documents = policy_scope(Document.fetch_all(options_filter))
    render json: DocumentSerializer.new(@documents).serializable_hash.to_json
  end

  def show
    authorize(@document)
    render json: DocumentSerializer.new(@document).serializable_hash.to_json
  end

  def create
    authorize(Document)
    document = @account.documents.new(document_create_params)
    document.owner_id = current_user.id
    if document.save
      render json: DocumentSerializer.new(document).serializable_hash.to_json, status: :created
    else
      render json: build_error_message(
        422, document.errors, 'document'
      ), status: :unprocessable_entity
    end
  end

  def update
    authorize(@document)
    if @document.update(document_update_params.to_h)
      render json: DocumentSerializer.new(@document).serializable_hash.to_json
    else
      render json: build_error_message(
        422, @document.errors.full_messages, 'document'
      ), status: :unprocessable_entity
    end
  end

  def destroy
    authorize(@document)
    @document.update(status: :deleted)
    head :no_content
  end

  private

  def document_create_params
    restify_param(:document).require(:document).permit(
      :resource_key, :name, :logo_url, { data: {} }
    )
  end

  def document_update_params
    restify_param(:document).require(:document).permit(
      :name, :status, :logo_url, { data: {} }
    )
  end

  def options_filter
    params.permit(
      :status
    )
  end

  def set_document
    @document = Document.find(params[:id]) || Document.find_by(uuid: params[:id])
    not_found unless @document
  end

  def set_account
    @account = Account.by_user_id(current_user.id)
    return if @account

    render json: build_error_message(
      422, "Account isn't created yet", 'account'
    ), status: :unprocessable_entity
  end
end
