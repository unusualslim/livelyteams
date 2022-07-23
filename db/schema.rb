# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_07_23_180535) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assets", force: :cascade do |t|
    t.bigint "location_id"
    t.bigint "equipment_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["equipment_id"], name: "index_assets_on_equipment_id"
    t.index ["location_id"], name: "index_assets_on_location_id"
  end

  create_table "case_comments", force: :cascade do |t|
    t.bigint "user_id"
    t.text "body"
    t.bigint "case_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["case_id"], name: "index_case_comments_on_case_id"
    t.index ["user_id"], name: "index_case_comments_on_user_id"
  end

  create_table "case_locations", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "location_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["case_id"], name: "index_case_locations_on_case_id"
    t.index ["location_id"], name: "index_case_locations_on_location_id"
  end

  create_table "case_users", force: :cascade do |t|
    t.bigint "case_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_case_users_on_case_id"
    t.index ["user_id"], name: "index_case_users_on_user_id"
  end

  create_table "cases", force: :cascade do |t|
    t.string "subject"
    t.text "description"
    t.bigint "location_id"
    t.bigint "status_id"
    t.bigint "severity_id"
    t.bigint "requested_by_id"
    t.bigint "assigned_to_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["assigned_to_id"], name: "index_cases_on_assigned_to_id"
    t.index ["location_id"], name: "index_cases_on_location_id"
    t.index ["requested_by_id"], name: "index_cases_on_requested_by_id"
    t.index ["severity_id"], name: "index_cases_on_severity_id"
    t.index ["status_id"], name: "index_cases_on_status_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "company"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "mobile_number"
    t.string "work_number"
    t.string "work_fax"
    t.string "home_number"
    t.text "notes"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "model"
    t.bigint "manufacturer_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["manufacturer_id"], name: "index_equipment_on_manufacturer_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "short_name"
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.text "note"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "severities", force: :cascade do |t|
    t.string "severity"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "asset_id"
    t.string "value"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["asset_id"], name: "index_taggings_on_asset_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "task_comments", force: :cascade do |t|
    t.text "body"
    t.bigint "task_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["task_id"], name: "index_task_comments_on_task_id"
    t.index ["user_id"], name: "index_task_comments_on_user_id"
  end

  create_table "task_lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_task_lists_on_user_id"
  end

  create_table "task_locations", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "location_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["location_id"], name: "index_task_locations_on_location_id"
    t.index ["task_id"], name: "index_task_locations_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "subject"
    t.bigint "location_id"
    t.bigint "status_id"
    t.text "description"
    t.bigint "severity_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "asset_id"
    t.bigint "task_list_id"
    t.bigint "requested_by_id"
    t.bigint "assigned_to_id"
    t.index ["asset_id"], name: "index_tasks_on_asset_id"
    t.index ["assigned_to_id"], name: "index_tasks_on_assigned_to_id"
    t.index ["location_id"], name: "index_tasks_on_location_id"
    t.index ["requested_by_id"], name: "index_tasks_on_requested_by_id"
    t.index ["severity_id"], name: "index_tasks_on_severity_id"
    t.index ["status_id"], name: "index_tasks_on_status_id"
    t.index ["task_list_id"], name: "index_tasks_on_task_list_id"
  end

  create_table "team_members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.bigint "role_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["role_id"], name: "index_team_members_on_role_id"
    t.index ["team_id"], name: "index_team_members_on_team_id"
    t.index ["user_id"], name: "index_team_members_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "things", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_things_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assets", "equipment"
  add_foreign_key "assets", "locations"
  add_foreign_key "case_comments", "cases"
  add_foreign_key "case_comments", "users"
  add_foreign_key "case_locations", "cases"
  add_foreign_key "case_locations", "locations"
  add_foreign_key "case_users", "cases"
  add_foreign_key "case_users", "users"
  add_foreign_key "cases", "locations"
  add_foreign_key "cases", "severities"
  add_foreign_key "cases", "statuses"
  add_foreign_key "cases", "users", column: "assigned_to_id"
  add_foreign_key "cases", "users", column: "requested_by_id"
  add_foreign_key "equipment", "manufacturers"
  add_foreign_key "notes", "users"
  add_foreign_key "taggings", "assets"
  add_foreign_key "taggings", "tags"
  add_foreign_key "task_comments", "tasks"
  add_foreign_key "task_comments", "users"
  add_foreign_key "task_lists", "users"
  add_foreign_key "task_locations", "locations"
  add_foreign_key "task_locations", "tasks"
  add_foreign_key "tasks", "assets"
  add_foreign_key "tasks", "locations"
  add_foreign_key "tasks", "severities"
  add_foreign_key "tasks", "statuses"
  add_foreign_key "tasks", "task_lists"
  add_foreign_key "tasks", "users", column: "assigned_to_id"
  add_foreign_key "tasks", "users", column: "requested_by_id"
  add_foreign_key "team_members", "roles"
  add_foreign_key "team_members", "teams"
  add_foreign_key "team_members", "users"
  add_foreign_key "things", "users"
end
