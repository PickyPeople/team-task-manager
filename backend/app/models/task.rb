class Task < ApplicationRecord
  belongs_to :user # 작성자
  belongs_to :workspace
end
