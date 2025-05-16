class WorkspacesController < ApplicationController
  before_action :authenticate_user!

  # POST /workspaces
  def create

    workspace = Workspace.new(workspace_params)
    workspace.user = @current_user
    workspace.owner = current_user.name

    if workspace.save

      WorkspaceUser.create(user: @current_user, workspace: workspace)


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

  # GET /workspaces
  def index
    workspaces = Workspace.all
    render json: workspaces
  end

  def show
    workspace = Workspace.find_by(id: params[:id])

    if workspace
      render json: {
        id: workspace.id,
        name: workspace.name,
        description: workspace.description,
        owner: workspace.owner,
        user_id: workspace.user_id,
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

  def join
    workspace = Workspace.find_by(id: params[:id])
    return render json: { error: "워크스페이스 없음" }, status: :not_found unless workspace

    if workspace.users.include?(@current_user)
      return render json: { message: "이미 참가함" }, status: :ok
    end

    workspace.users << @current_user
    render json: { message: "워크스페이스 참가 완료" }, status: :ok
  end

  def participants
    workspace = Workspace.find_by(id: params[:id])
    return render json: { error: "워크스페이스 없음" }, status: :not_found unless workspace

    render json: workspace.users.select(:id, :name, :email)
  end

  def leave
  workspace = Workspace.find_by(id: params[:id])
  return render json: { error: "워크스페이스 없음" }, status: :not_found unless workspace

  if workspace.users.include?(@current_user)
    workspace.users.destroy(@current_user)
    render json: { message: "탈퇴 완료" }, status: :ok
  else
    render json: { error: "이미 참가하지 않은 상태입니다." }, status: :bad_request
  end
end

def progress
  workspace = Workspace.find(params[:id])
  users = workspace.users + [workspace.user]
  users.uniq!

  result = users.map do |user|
    tasks = workspace.tasks.where(assignee_id: user.id)
    total = tasks.count
    completed = tasks.where(status: 'completed').count
    progress = total > 0 ? ((completed.to_f / total) * 100).round(1) : 0.0

    {
      user_id: user.id,
      name: user.name,
      progress: progress
    }
  end

  render json: result
end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description)
  end
end
