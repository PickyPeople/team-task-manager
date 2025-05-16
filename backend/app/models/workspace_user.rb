class WorkspaceUser < ApplicationRecord
  belongs_to :user
  belongs_to :workspace

  after_destroy :destroy_tasks_in_workspace

  private

  def destroy_tasks_in_workspace
    Task.where(user: user, workspace: workspace).destroy_all
  end
end
