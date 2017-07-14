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

ActiveRecord::Schema.define(version: 20170714202123) do

  create_table "administradores", force: :cascade do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "asignaciones", force: :cascade do |t|
    t.integer  "profesor_id"
    t.integer  "curso_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "citas", force: :cascade do |t|
    t.string   "tipo_cita"
    t.boolean  "asistio"
    t.text     "comentarios"
    t.boolean  "cancelada"
    t.string   "cancelada_por"
    t.integer  "cancelada_por_id"
    t.string   "fecha_cancelacion"
    t.string   "fecha_inicio"
    t.string   "fecha_fin"
    t.text     "informacion_para_cita"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
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
    t.text     "comentarios_plazas"
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

  create_table "horarios", force: :cascade do |t|
    t.string   "fecha_inicio"
    t.string   "fecha_fin"
    t.boolean  "disponible"
    t.integer  "administrador_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
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
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "curso_id"
    t.string   "semestre_curso"
    t.text     "comentarios"
    t.string   "semestre"
    t.boolean  "doble_monitor"
    t.string   "nombre_profesor"
    t.string   "segundo_curso"
    t.boolean  "monitoria_otro_departamento"
    t.decimal  "nota_monitoria"
    t.boolean  "entrego_documentos"
    t.boolean  "firmo_convenio"
    t.string   "estado_segundo_curso"
    t.index ["curso_id"], name: "index_monitorias_on_curso_id"
  end

  create_table "practicas", force: :cascade do |t|
    t.string   "semestre"
    t.boolean  "charla"
    t.text     "comentarios"
    t.integer  "estudiante_id"
    t.string   "estado"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "profesores", force: :cascade do |t|
    t.string   "nombres"
    t.string   "apellidos"
    t.string   "email"
    t.string   "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saber_pros", force: :cascade do |t|
    t.string   "tipo_documento"
    t.string   "fecha_nacimiento"
    t.boolean  "pago"
    t.text     "observaciones"
    t.boolean  "inscrito"
    t.integer  "estudiante_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
