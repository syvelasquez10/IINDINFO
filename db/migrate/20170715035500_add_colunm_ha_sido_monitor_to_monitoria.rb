class AddColunmHaSidoMonitorToMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :ha_sido_monitor, :boolean
    add_column :monitorias, :comentarios_estudiante, :text
    add_column :practicas, :fecha_limite, :string
  end
end
