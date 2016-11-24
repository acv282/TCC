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

ActiveRecord::Schema.define(version: 20161122235507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fasta_logs", force: :cascade do |t|
    t.integer  "organism_id"
    t.text     "descricao"
    t.binary   "stream"
    t.datetime "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "fasta_logs", ["organism_id"], name: "index_fasta_logs_on_organism_id", using: :btree

  create_table "gbk_logs", force: :cascade do |t|
    t.integer  "organism_id"
    t.text     "descricao"
    t.binary   "stream"
    t.datetime "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "gbk_logs", ["organism_id"], name: "index_gbk_logs_on_organism_id", using: :btree

  create_table "gff_logs", force: :cascade do |t|
    t.integer  "organism_id"
    t.text     "descricao"
    t.binary   "stream"
    t.datetime "data"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "gff_logs", ["organism_id"], name: "index_gff_logs_on_organism_id", using: :btree

  create_table "organism_statuses", force: :cascade do |t|
    t.text     "descricao"
    t.text     "visibilidade"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "organisms", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "organism_status_id"
    t.text     "nome"
    t.text     "descricao"
    t.boolean  "status_ace"
    t.binary   "stream_fasta"
    t.binary   "stream_gbk"
    t.binary   "stream_gff"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "organisms", ["project_id"], name: "index_organisms_on_project_id", using: :btree

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
    t.string   "nomeExibicao", limit: 40
    t.string   "senha"
    t.string   "senha_salt"
    t.string   "email",        limit: 50
    t.string   "permissao",    limit: 1
    t.boolean  "status_ace"
    t.integer  "u_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "motivo"
  end

end
