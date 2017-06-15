class CreateMonitorias < ActiveRecord::Migration[5.0]
  def change
    create_table :monitorias do |t|
      t.string :estado
      t.boolean :notificaciones
      t.decimal :nota_curso
      t.integer :estudiante_id
      t.integer :curso_id

      t.timestamps
    end
  end
end
