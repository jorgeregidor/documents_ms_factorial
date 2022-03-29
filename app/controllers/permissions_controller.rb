# frozen_string_literal: true

class PermissionsController < ApplicationController
  before_action :set_document
  before_action :set_permission,    only: %i[show update destroy]
  after_action  :verify_authorized, except: %i[index]

  # GET document/:document_id/permissions
  def index
    authorize(@document, :show?)
    @permissions = @document.permissions.all
    render json: PermissionSerializer.new(@permissions).serializable_hash.to_json
  end

  # GET /documents/:document_id/permissions/1
  def show
    authorize(@document)
    render json: PermissionSerializer.new(@permission).serializable_hash.to_json
  end

  # POST /documents/:document_id/permissions
  def create
    authorize(@document, :update?)
    @permission = @document.permissions.new(permission_params)

    if @permission.save
      render json: PermissionSerializer.new(@permission).serializable_hash.to_json, status: :created
    else
      render json: build_error_message(
        422, @permission.errors, 'permission'
      ), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /documents/:document_id/permissions/:id
  def update
    authorize(@document, :update?)
    if @permission.update(permission_params)
      render json: PermissionSerializer.new(@permission).serializable_hash.to_json
    else
      render json: build_error_message(
        422, @permission.errors, 'permission'
      ), status: :unprocessable_entity
    end
  end

  # DELETE /documents/:document_id/permissions/:id
  def destroy
    authorize(@document, :update?)
    @permission.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:document_id]) || Document.find_by(uuid: params[:document_id])
    return if @document

    render json: build_error_message(
      422, "Document isn't created yet", 'document'
    ), status: :unprocessable_entity
  end

  def set_permission
    @permission = @document.permissions.find(params[:id]) || @document.permissions.find_by(uuid: params[:id])
    return if @permission

    render json: build_error_message(
      404, "Permission isn't created yet", 'permission'
    ), status: :not_found
  end

  # Only allow a trusted parameter "white list" through.
  def permission_params
    restify_param(:permission).require(:permission).permit(
      :read, :write, :user_id
    )
  end
end
