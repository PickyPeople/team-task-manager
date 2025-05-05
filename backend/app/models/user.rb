class User < ApplicationRecord
  has_secure_password

  has_many :workspace_users
  has_many :workspaces, through: :workspace_users
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assignee_id"
end
