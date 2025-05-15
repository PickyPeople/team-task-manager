class Workspace < ApplicationRecord
  belongs_to :user  # User와 연결되어 있음

  validates :name, presence: true
  validates :description, presence: true
  validates :owner, presence: true

  has_many :tasks, dependent: :destroy
  has_many :workspace_users, dependent: :destroy
  has_many :users, through: :workspace_users
end
