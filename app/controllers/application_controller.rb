class ApplicationController < ActionController::API
  before_action :authenticate_user

  private

  def authenticate_user
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base).first
      @current_user = User.find(decoded['user_id'])
    rescue JWT::DecodeError
      render json: { errors: ['Invalid token'] }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ['User not found'] }, status: :unauthorized
    end
  end

  attr_reader :current_user
end
