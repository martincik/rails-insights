class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :restrict_access, if: -> { %w[production staging].include?(Rails.env) && Rails.application.secrets.http_basic_auth.present? }

  protected

  def restrict_access
    authenticate_or_request_with_http_basic do |username, password|
      credentials = Rails.application.secrets.http_basic_auth.symbolize_keys
      username == credentials[:username] && password == credentials[:password]
    end
  end
end
