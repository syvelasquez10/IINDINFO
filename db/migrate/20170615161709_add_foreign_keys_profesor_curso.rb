class AddForeignKeysProfesorCurso < ActiveRecord::Migration[5.0]
  def change
    add_column :cursos, :profesor_id, :integer
  end
end
