class CreateCursos < ActiveRecord::Migration[5.0]
  def change
    create_table :cursos do |t|
      t.string :nombre_curso
      t.string :codigo_curso
      t.integer :monitores_solicitados
      t.integer :monitores_requeridos
      t.string :estado
      t.integer :inscritos

      t.timestamps
    end
  end
end
