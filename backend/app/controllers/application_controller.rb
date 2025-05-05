class ApplicationController < ActionController::API
  #POST /logout
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
end
