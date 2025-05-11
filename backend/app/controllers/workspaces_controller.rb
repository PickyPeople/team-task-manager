class WorkspacesController < ApplicationController
  before_action :authenticate_user!

  # POST /workspaces
  def create
    # 📡 Authorization 헤더 로그 출력
    # Rails.logger.info "📡 Authorization 헤더: #{request.headers['Authorization']}"
    # Rails.logger.info "📦 전달된 파라미터: #{params[:workspace]}"

    if @current_user.nil?
      Rails.logger.error "🚫 인증되지 않은 사용자입니다."
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    
    workspace = Workspace.new(workspace_params)
    workspace.user = @current_user
    workspace.owner = current_user.name

    if workspace.save
      # Rails.logger.info "✅ 워크스페이스 생성 성공: #{workspace.as_json}"
      render json: {
        id: workspace.id,
        name: workspace.name,
        description: workspace.description,
        owner: workspace.owner
      }, status: :created
    else
      # Rails.logger.error "🚫 워크스페이스 생성 실패: #{workspace.errors.full_messages}"
      render json: { error: workspace.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # ✅ GET /workspaces
  def index
    workspaces = Workspace.where(user_id: @current_user.id)
    render json: workspaces, status: :ok
  end

  def show
    workspace = Workspace.find_by(id: params[:id], user_id: @current_user.id)

    if workspace
      render json: {
        id: workspace.id,
        name: workspace.name,
        description: workspace.description,
        owner: workspace.owner,
        created_at: workspace.created_at,
        updated_at: workspace.updated_at
      }, status: :ok
    else
      render json: { error: "워크스페이스를 찾을 수 없습니다." }, status: :not_found
    end
  end

  def update
    workspace = Workspace.find_by(id: params[:id], user_id: @current_user.id)

    if workspace.nil?
      render json: { error: "워크스페이스를 찾을 수 없습니다." }, status: :not_found
      return
    end

    if workspace.update(workspace_params)
      render json: {
        id: workspace.id,
        name: workspace.name,
        description: workspace.description,
        owner: workspace.owner,
        updated_at: workspace.updated_at
      }, status: :ok
    else
      render json: { error: workspace.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    workspace = Workspace.find_by(id: params[:id], user_id: @current_user.id)

    if workspace
      workspace.destroy
      render json: { message: "워크스페이스가 삭제되었습니다." }, status: :ok
    else
      render json: { error: "워크스페이스를 찾을 수 없습니다." }, status: :not_found
    end
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description)
  end
end
