class V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :restrict_access
  helper_method :current_user
  respond_to :json
  rescue_from StandardError,                      with: :error_handler
  rescue_from ActiveRecord::RecordNotFound,       with: :not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing
  rescue_from ActiveRecord::RecordInvalid,        with: :invalid_params

  def routing_error
    not_found
  end

  private

  def not_found
    render nothing: true, status: 404
  end

  def params_missing(exception)
    render_error_message(exception)
  end

  def invalid_params(exception)
    render_error_message(exception)
  end

  def error_handler(exception)
    if exception.is_a?(PG::InvalidTextRepresentation) and exception.message.include?('uuid')
      not_found
    else
      render_error_message(exception)
    end
  end

  def render_error_message(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def restrict_access
    render nothing: true, status: :forbidden unless current_user
  end

  def current_user
    @current_user ||= User.find_by(api_token: current_token)
  end

  def current_token
    request.headers["X-API-TOKEN"] || params[:api_token]
    # allows tests to pass
    # api_token ||= request.headers["rack.session"].try(:[], 'X-API-TOKEN')
  end

end