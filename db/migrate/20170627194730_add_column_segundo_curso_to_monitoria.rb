class AddColumnSegundoCursoToMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :segundo_curso, :string
  end
end
