# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  # 모든 요청 전에 인증 로직을 실행
  before_action :authenticate_user!

  # POST /logout
  def logout
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    decoded = JsonWebToken.decode(token)

    if decoded && User.exists?(id: decoded[:user_id])
      render json: { message: "ログアウトに成功しました。" }, status: :ok
    else 
      render json: { error: "ログアウトに失敗しました。" }, status: :unauthorized
    end
  end

  private

  # ✅ 인증 로직 추가
  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    decoded = JsonWebToken.decode(token)

    if decoded && User.exists?(id: decoded[:user_id])
      @current_user = User.find(decoded[:user_id])
      Rails.logger.info "✅ 사용자 인증 성공: #{@current_user.email}"
    else
      Rails.logger.error "🚫 사용자 인증 실패"
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  rescue JWT::DecodeError => e
    Rails.logger.error "🚫 JWT 디코딩 실패: #{e.message}"
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
