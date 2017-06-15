class Arreglos < ActiveRecord::Migration[5.0]
  def change
    remove_column :estudiantes, :monitoria_id1
    remove_column :estudiantes, :monitoria_id2
    create_table :cartelera_cursos do |t|
      t.integer :profesor_id
      t.integer :curso_id

      t.timestamps
    end
  end
end
