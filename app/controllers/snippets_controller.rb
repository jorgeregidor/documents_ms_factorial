# frozen_string_literal: true

class SnippetsController < ApplicationController
  before_action :set_account
  before_action :set_snippet, only: %i[show update destroy]
  after_action  :verify_authorized, except: %i[index]

  # GET /snippets
  def index
    authorize(@account)
    @snippets = @account.snippets.all
    render json: SnippetSerializer.new(@snippets).serializable_hash.to_json
  end

  # GET /snippets/1
  def show
    authorize(@account)
    render json: SnippetSerializer.new(@snippet).serializable_hash.to_json
  end

  # POST /snippets
  def create
    authorize(@account, :update?)
    @snippet = @account.snippets.new(snippet_params)

    if @snippet.save
      render json: SnippetSerializer.new(@snippet).serializable_hash.to_json, status: :created
    else
      render json: build_error_message(
        422, @snippet.errors, 'snippet'
      ), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /snippets/:id
  def update
    authorize(@account, :update?)
    if @snippet.update(snippet_params)
      render json: SnippetSerializer.new(@snippet).serializable_hash.to_json
    else
      render json: build_error_message(
        422, @snippet.errors, 'snippet'
      ), status: :unprocessable_entity
    end
  end

  # DELETE /snippets/:id
  def destroy
    authorize(@account, :update?)
    @snippet.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.by_user_id(current_user.id)
    return if @account

    render json: build_error_message(
      422, "Account isn't created yet", 'account'
    ), status: :unprocessable_entity
  end

  def set_snippet
    @snippet = @account.snippets.find(params[:id]) || @account.snippets.find_by(uuid: params[:id])
    return if @snippet

    render json: build_error_message(
      404, "Snippet isn't created yet", 'snippet'
    ), status: :not_found
  end

  # Only allow a trusted parameter "white list" through.
  def snippet_params
    restify_param(:snippet).require(:snippet).permit(
      :input_key, :input_value
    )
  end
end
