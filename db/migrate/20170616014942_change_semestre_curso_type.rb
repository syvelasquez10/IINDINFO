class ChangeSemestreCursoType < ActiveRecord::Migration[5.0]
  def change
    remove_column :monitorias, :semestre_curso
    add_column :monitorias, :semestre_curso, :string
  end
end
