ActiveRecord::Schema[8.0].define(version: 2025_05_16_073710) do
  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.integer "workspace_id"
    t.integer "assignee_id"
    t.boolean "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workspace_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workspace_users_on_user_id"
    t.index ["workspace_id"], name: "index_workspace_users_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_workspaces_on_user_id"
  end

  add_foreign_key "tasks", "users"
  add_foreign_key "workspace_users", "users"
  add_foreign_key "workspace_users", "workspaces"
  add_foreign_key "workspaces", "users"
end
