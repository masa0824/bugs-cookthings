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

ActiveRecord::Schema.define(version: 2022_05_16_023317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "food_stuff_templates", force: :cascade do |t|
    t.string "food_kind", limit: 255
    t.string "food_stuff", limit: 255
    t.integer "amount"
    t.string "mass", limit: 255
    t.bigint "recipe_template_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_template_id"], name: "index_food_stuff_templates_on_recipe_template_id"
  end

  create_table "food_stuffs", force: :cascade do |t|
    t.string "food_kind", limit: 255
    t.string "food_stuff", limit: 255
    t.integer "amount"
    t.string "mass", limit: 255
    t.bigint "recipe_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_food_stuffs_on_recipe_id"
  end

  create_table "news", force: :cascade do |t|
    t.boolean "status", null: false
    t.datetime "news_date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "title", limit: 50
    t.text "article"
    t.string "category", limit: 50
    t.string "tag", limit: 50
  end

  create_table "recipe_templates", force: :cascade do |t|
    t.string "recipe_name", limit: 255
    t.string "category", limit: 255
    t.datetime "cook_at"
    t.bigint "user_id"
    t.boolean "is_original", default: false, null: false
    t.string "kind", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "select_images_id", default: 0, null: false, comment: "0 -> 未使用｜1以上 -> 指定画像"
    t.index ["select_images_id"], name: "index_recipe_templates_on_select_images_id"
    t.index ["user_id"], name: "index_recipe_templates_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "recipe_name", limit: 255
    t.string "category", limit: 255
    t.datetime "cook_at"
    t.bigint "user_id"
    t.boolean "is_original", default: false, null: false
    t.string "kind", limit: 255
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "select_images_id", default: 0, null: false, comment: "0 -> 未使用｜1以上 -> 指定画像"
    t.index ["select_images_id"], name: "index_recipes_on_select_images_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "select_images", force: :cascade do |t|
    t.integer "sort_num"
    t.string "food_name", limit: 255
    t.string "file_name", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255, null: false
    t.string "password_digest", null: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.integer "acount_plan", limit: 2, default: 1, null: false, comment: "1 -> 無料プラン｜2 -> 有料プラン"
    t.boolean "acount_lock", default: false, null: false, comment: "1 -> 無料プラン｜2 -> 有料プラン"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "check_latest_news", default: false, null: false, comment: "true -> チェック済み｜false -> 未チェック"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "food_stuff_templates", "recipe_templates"
  add_foreign_key "food_stuffs", "recipes"
  add_foreign_key "recipe_templates", "users"
  add_foreign_key "recipes", "users"
end
