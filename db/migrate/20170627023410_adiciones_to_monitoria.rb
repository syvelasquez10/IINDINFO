class AdicionesToMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :semestre, :string
    add_column :monitorias, :doble_monitor, :boolean
    add_column :monitorias, :nombre_profesor, :string
  end
end
