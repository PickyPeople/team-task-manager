class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :done, default: false
      t.references :workspace, null: false, foreign_key: true
      t.integer :assignee_id
      t.foreign_key :users, column: :assignee_id

      t.timestamps
    end
  end
end
