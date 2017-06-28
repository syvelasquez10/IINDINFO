class AddColumnToMonitoria < ActiveRecord::Migration[5.0]
  def change
    add_column :monitorias, :monitoria_otro_departamento, :boolean
  end
end
