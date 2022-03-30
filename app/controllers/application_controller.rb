# frozen_string_literal: true

# Shared methods
class ApplicationController < ActionController::API
  include Authorization
  include Pundit::Authorization

  before_action :build_current_user

  rescue_from ActionController::RoutingError,     with: :not_found
  rescue_from Mongoid::Errors::DocumentNotFound,  with: :not_found
  rescue_from ActionController::ParameterMissing, with: :unprocessable_params
  rescue_from Pundit::NotAuthorizedError,         with: :forbidden

  protected

  def unprocessable_params
    render json: {
      errors: [{
        status: 400,
        title: 'filter param is missing or the value is empty.'
      }]
    }, status: 400
  end

  def not_found
    render json: {
      errors: [{ status: 404, title: 'Not found' }]
    }, status: :not_found
  end

  def build_error_message(status, messages, object)
    {
      errors: [
        {
          title: "Can't #{action_name} #{object}.",
          messages: messages,
          status: status
        }
      ]
    }
  end

  def forbidden
    render json: {
      errors: [{ status: 403, title: 'You are not authorized to perform this action.' }]
    }, status: :forbidden
  end
end
