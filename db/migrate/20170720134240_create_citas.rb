class CreateNoticias < ActiveRecord::Migration[5.0]
  def change
    create_table :citas do |t|
      t.string :tipo_cita
      t.boolean :asistio
      t.text :comentarios
      t.boolean :cancelada
      t.string :cancelada_por
      t.integer  "cancelada_por_id"
      t.string   "fecha_cancelacion"
      t.string   "fecha_inicio"
      t.string   "fecha_fin"
      t.text     "informacion_para_cita"
      t.integer  "estudiante_id"
      t.integer  "administrador_id"
    end
  end
end
