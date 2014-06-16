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

ActiveRecord::Schema.define(version: 20140505094810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "articles", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.text     "title"
    t.text     "url"
    t.text     "description"
    t.uuid     "feed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url"
    t.text     "entry_id"
    t.datetime "published_at"
  end

  add_index "articles", ["created_at"], name: "index_articles_on_created_at", using: :btree
  add_index "articles", ["entry_id"], name: "index_articles_on_entry_id", using: :btree
  add_index "articles", ["published_at"], name: "index_articles_on_published_at", using: :btree
  add_index "articles", ["title"], name: "index_articles_on_title", using: :btree

  create_table "favorite_articles", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.uuid     "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorite_articles", ["article_id"], name: "index_favorite_articles_on_article_id", using: :btree
  add_index "favorite_articles", ["user_id"], name: "index_favorite_articles_on_user_id", using: :btree

  create_table "feeds", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "title"
    t.text     "url"
    t.uuid     "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["title"], name: "index_feeds_on_title", using: :btree
  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id", using: :btree

  create_table "tagged_feeds", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "feed_id"
    t.uuid     "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tagged_feeds", ["feed_id"], name: "index_tagged_feeds_on_feed_id", using: :btree
  add_index "tagged_feeds", ["tag_id"], name: "index_tagged_feeds_on_tag_id", using: :btree

  create_table "tags", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["title"], name: "index_tags_on_title", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "email"
    t.string   "api_token"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["api_token"], name: "index_users_on_api_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree

end
