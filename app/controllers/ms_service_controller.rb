# frozen_string_literal: true

# Health chacks and missing routes
class MsServiceController < ApplicationController
  skip_before_action :build_current_user

  def show
    render json: json_response, status: :ok
  end

  def error_404
    raise ActionController::RoutingError, params[:path]
  end

  private

  def json_response
    {
      data: [
        {
          type: 'health',
          attributes: {
            status: 'OK'
          }
        }
      ]
    }
  end
end
