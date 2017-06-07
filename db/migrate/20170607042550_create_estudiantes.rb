class CreateEstudiantes < ActiveRecord::Migration[5.0]
  def change
    create_table :estudiantes do |t|
      t.string :carnet
      t.string :apellidos
      t.string :nombres
      t.string :programa
      t.string :doble_programa
      t.string :doc_identidad
      t.string :fecha_nac
      t.string :sexo
      t.string :ciudad
      t.string :celular
      t.string :sit_academica
      t.decimal :cred_tomados
      t.decimal :cred_aprobados
      t.decimal :cred_pga
      t.decimal :prom_acum
      t.decimal :cred_transf
      t.decimal :ssc
      t.string :email
      t.decimal :cred_sem_actual

      t.timestamps
    end
  end
end
