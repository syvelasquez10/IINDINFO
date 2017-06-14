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

ActiveRecord::Schema.define(version: 20170614172517) do

  create_table "administradores", force: :cascade do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cursos", force: :cascade do |t|
    t.string   "nombre_curso"
    t.string   "codigo_curso"
    t.integer  "monitores_solicitados"
    t.integer  "monitores_requeridos"
    t.string   "estado"
    t.integer  "inscritos"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
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
    t.integer  "monitoria_id"
    t.integer  "monitoria_id2"
  end

  create_table "materia_fantasmas", force: :cascade do |t|
    t.string   "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monitorias", force: :cascade do |t|
    t.string   "estado"
    t.boolean  "notificaciones"
    t.decimal  "nota_curso"
    t.integer  "estudiante_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "curso_id"
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
