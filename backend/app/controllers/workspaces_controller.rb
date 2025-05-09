class WorkspacesController < ApplicationController
  # POST /workspaces
  def create
    # 📡 Authorization 헤더 로그 출력
    Rails.logger.info "📡 Authorization 헤더: #{request.headers['Authorization']}"
    Rails.logger.info "📦 전달된 파라미터: #{params[:workspace]}"

    if @current_user.nil?
      Rails.logger.error "🚫 인증되지 않은 사용자입니다."
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    # ✅ user를 명시적으로 설정
    workspace = Workspace.new(workspace_params)
    workspace.user = @current_user
    workspace.owner = @current_user.name

    if workspace.save
      Rails.logger.info "✅ 워크스페이스 생성 성공: #{workspace.as_json}"
      render json: {
        id: workspace.id,
        name: workspace.name,
        description: workspace.description,
        owner: workspace.owner
      }, status: :created
    else
      Rails.logger.error "🚫 워크스페이스 생성 실패: #{workspace.errors.full_messages}"
      render json: { error: workspace.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # ✅ GET /workspaces
  def index
    workspaces = Workspace.where(user_id: @current_user.id)
    render json: workspaces, status: :ok
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description)
  end
end
