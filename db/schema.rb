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

ActiveRecord::Schema.define(version: 20170607042550) do

  create_table "administradores", force: :cascade do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estudiantes", force: :cascade do |t|
    t.string   "carnet"
    t.string   "apellidos"
    t.string   "nombres"
    t.string   "programa"
    t.string   "doble_programa"
    t.string   "doc_identidad"
    t.string   "fecha_nac"
    t.string   "sexo"
    t.string   "ciudad"
    t.string   "celular"
    t.string   "sit_academica"
    t.decimal  "cred_tomados"
    t.decimal  "cred_aprobados"
    t.decimal  "cred_pga"
    t.decimal  "prom_acum"
    t.decimal  "cred_transf"
    t.decimal  "ssc"
    t.string   "email"
    t.decimal  "cred_sem_actual"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "profesores", force: :cascade do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "email"
    t.string   "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end