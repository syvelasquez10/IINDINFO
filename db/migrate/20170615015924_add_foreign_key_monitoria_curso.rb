class AddForeignKeyMonitoriaCurso < ActiveRecord::Migration[5.0]
  def change
    add_reference :monitorias, :curso, foreign_key: true
  end
end
