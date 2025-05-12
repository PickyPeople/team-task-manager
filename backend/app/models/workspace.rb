class Workspace < ApplicationRecord
  belongs_to :user  # 💡 User와 연결되어 있음

  validates :name, presence: true
  validates :description, presence: true
  validates :owner, presence: true

  has_many :tasks, dependent: :destroy
end
