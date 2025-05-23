class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :workspace_users
  has_many :workspaces, through: :workspace_users
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assignee_id"
end
