class AddColumnsToMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :entrego_documentos, :boolean
    add_column :monitorias, :firmo_convenio, :boolean
    add_column :monitorias, :estado_segundo_curso, :string
    add_column :cursos, :comentarios_plazas, :text
  end
end
