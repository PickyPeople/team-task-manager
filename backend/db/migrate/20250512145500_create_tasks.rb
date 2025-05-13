class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :workspace_id
      t.integer :assignee_id
      t.boolean :done

      t.timestamps
    end
  end
end
