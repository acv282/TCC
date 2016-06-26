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

ActiveRecord::Schema.define(version: 20160625065933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.text     "nome"
    t.text     "descricao"
    t.date     "dt_ini"
    t.boolean  "status_ace"
    t.text     "andamento"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_roles", force: :cascade do |t|
    t.text     "nivel"
    t.text     "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "team_role_id"
    t.text     "nome"
    t.text     "descricao"
    t.boolean  "status_ace"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.text     "nivel"
    t.text     "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "user_role_id"
    t.string   "nomeUsuario",  limit: 20
    t.string   "nomeExibicao", limit: 40
    t.string   "senha"
    t.string   "senha_salt"
    t.string   "email",        limit: 50
    t.string   "permissao",    limit: 1
    t.boolean  "status_ace"
    t.integer  "u_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
