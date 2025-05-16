class Task < ApplicationRecord
  belongs_to :user # 작성자
  belongs_to :workspace

  validates :title, presence: true
  validates :status, presence: true
end
