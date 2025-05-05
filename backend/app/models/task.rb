class Task < ApplicationRecord
  belongs_to :workspace
  belongs_to :assignee, class_name: 'User'
end
