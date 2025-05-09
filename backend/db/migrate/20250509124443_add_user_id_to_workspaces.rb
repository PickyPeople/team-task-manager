class AddUserIdToWorkspaces < ActiveRecord::Migration[8.0]
  def change
    add_reference :workspaces, :user, null: false, foreign_key: true
  end
end
