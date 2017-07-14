class CreateHorarios < ActiveRecord::Migration[5.0]
  def change
    create_table :horarios do |t|
      t.string :fecha_inicio
      t.string :fecha_fin
      t.boolean :disponible
      t.integer :administrador_id

      t.timestamps
    end
  end
end
