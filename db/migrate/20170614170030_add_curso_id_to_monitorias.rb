class AddCursoIdToMonitorias < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :curso_id, :integer
  end
end
