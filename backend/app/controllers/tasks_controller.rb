class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workspace
  before_action :set_task, only: [:show, :update, :destroy]

  # 특정 워크스페이스의 Task 목록 조회
  def index
  tasks = @workspace.tasks.includes(:user) # 작성자 미리 로딩

  render json: tasks.map { |task|
    {
      id: task.id,
      title: task.title,
      description: task.description,
      status: task.status,
      done: task.done,
      assignee_id: task.assignee_id,
      creator_id: task.user_id,
      creator_name: task.user.name
    }
  }, status: :ok
end

  # Task 생성
  def create
  task = @workspace.tasks.build(task_params)
  task.user = @current_user # 작성자 설정

  if task.save
    render json: {
      id: task.id,
      title: task.title,
      description: task.description,
      status: task.status,
      done: task.done,
      assignee_id: task.assignee_id,
      creator_id: task.user_id,
      creator_name: task.user.name
    }, status: :created
  else
    render json: { error: task.errors.full_messages }, status: :unprocessable_entity
  end
end

  def show
    render json: @task, status: :ok
  end

  # Task 수정
  def update
   unless @workspace.users.include?(@current_user) || @workspace.user == @current_user
      render json: { error: "수정 권한이 없습니다." }, status: :forbidden
      return
    end
  
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { error: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Task 삭제
  def destroy
    unless @workspace.users.include?(@current_user) || @workspace.user == @current_user
      render json: { error: "삭제 권한이 없습니다." }, status: :forbidden
      return
    end

    @task.destroy
    render json: { message: "Task가 성공적으로 삭제되었습니다." }, status: :ok
  end

  private

  # 특정 워크스페이스 찾기
  def set_workspace
    @workspace = Workspace.find_by(id: params[:workspace_id])
    if @workspace.nil?
      render json: { error: "워크스페이스를 찾을 수 없습니다." }, status: :not_found
    end
  end

  # 특정 Task 찾기
  def set_task
    @task = @workspace.tasks.find_by(id: params[:id])
    if @task.nil?
      render json: { error: "Task를 찾을 수 없습니다." }, status: :not_found
    end
  end

  # Strong Parameters
  def task_params
    params.require(:task).permit(:title, :description, :status, :done, :assignee_id)
  end
end
