﻿class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception, prepend: true
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  def error_render_method
    render nothing: true, status: :not_found
    Rails.logger.info(@request)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end
end
