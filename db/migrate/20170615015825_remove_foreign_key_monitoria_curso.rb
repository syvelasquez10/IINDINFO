class RemoveForeignKeyMonitoriaCurso < ActiveRecord::Migration[5.0]
  def change
    remove_reference :monitorias, :cursos, foreign_key: true
  end
end
