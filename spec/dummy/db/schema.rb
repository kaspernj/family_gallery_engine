# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150508081950) do

  create_table "family_gallery_group_picture_links", force: true do |t|
    t.integer  "group_id"
    t.integer  "picture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "family_gallery_group_picture_links", ["group_id", "picture_id"], name: "unique_group_and_picture", unique: true, using: :btree
  add_index "family_gallery_group_picture_links", ["group_id"], name: "index_family_gallery_group_picture_links_on_group_id", using: :btree
  add_index "family_gallery_group_picture_links", ["picture_id"], name: "index_family_gallery_group_picture_links_on_picture_id", using: :btree

  create_table "family_gallery_group_translations", force: true do |t|
    t.integer  "family_gallery_group_id", null: false
    t.string   "locale",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "family_gallery_group_translations", ["family_gallery_group_id"], name: "index_c7c2d0e178c1bd38d1d9010438b10c5b4240a1db", using: :btree
  add_index "family_gallery_group_translations", ["locale"], name: "index_family_gallery_group_translations_on_locale", using: :btree

  create_table "family_gallery_groups", force: true do |t|
    t.integer  "user_owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "family_gallery_groups", ["user_owner_id"], name: "index_family_gallery_groups_on_user_owner_id", using: :btree

  create_table "family_gallery_picture_translations", force: true do |t|
    t.integer  "family_gallery_picture_id", null: false
    t.string   "locale",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
  end

  add_index "family_gallery_picture_translations", ["family_gallery_picture_id"], name: "index_832f502cff7d47b4d637c290646c30a7e18d7e2f", using: :btree
  add_index "family_gallery_picture_translations", ["locale"], name: "index_family_gallery_picture_translations_on_locale", using: :btree

  create_table "family_gallery_pictures", force: true do |t|
    t.integer  "user_owner_id"
    t.integer  "user_uploaded_id"
    t.datetime "taken_at"
    t.integer  "width"
    t.integer  "height"
    t.decimal  "latitude",           precision: 10, scale: 8
    t.decimal  "longitude",          precision: 10, scale: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "family_gallery_pictures", ["latitude"], name: "index_family_gallery_pictures_on_latitude", using: :btree
  add_index "family_gallery_pictures", ["longitude"], name: "index_family_gallery_pictures_on_longitude", using: :btree
  add_index "family_gallery_pictures", ["taken_at"], name: "index_family_gallery_pictures_on_taken_at", using: :btree
  add_index "family_gallery_pictures", ["user_owner_id"], name: "index_family_gallery_pictures_on_user_owner_id", using: :btree
  add_index "family_gallery_pictures", ["user_uploaded_id"], name: "index_family_gallery_pictures_on_user_uploaded_id", using: :btree

  create_table "family_gallery_user_roles", force: true do |t|
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "family_gallery_user_roles", ["user_id", "role"], name: "index_family_gallery_user_roles_on_user_id_and_role", unique: true, using: :btree
  add_index "family_gallery_user_roles", ["user_id"], name: "index_family_gallery_user_roles_on_user_id", using: :btree

  create_table "family_gallery_user_taggings", force: true do |t|
    t.integer  "picture_id"
    t.integer  "user_id"
    t.integer  "tagged_by_id"
    t.decimal  "position_top",  precision: 10, scale: 2
    t.decimal  "position_left", precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "family_gallery_user_taggings", ["picture_id"], name: "index_family_gallery_user_taggings_on_picture_id", using: :btree
  add_index "family_gallery_user_taggings", ["tagged_by_id"], name: "index_family_gallery_user_taggings_on_tagged_by_id", using: :btree
  add_index "family_gallery_user_taggings", ["user_id"], name: "index_family_gallery_user_taggings_on_user_id", using: :btree

  create_table "family_gallery_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "family_gallery_users", ["confirmation_token"], name: "index_family_gallery_users_on_confirmation_token", unique: true, using: :btree
  add_index "family_gallery_users", ["email"], name: "index_family_gallery_users_on_email", unique: true, using: :btree
  add_index "family_gallery_users", ["reset_password_token"], name: "index_family_gallery_users_on_reset_password_token", unique: true, using: :btree
  add_index "family_gallery_users", ["unlock_token"], name: "index_family_gallery_users_on_unlock_token", unique: true, using: :btree

end
