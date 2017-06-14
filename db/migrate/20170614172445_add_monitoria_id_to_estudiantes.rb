class AddMonitoriaIdToEstudiantes < ActiveRecord::Migration[5.0]
  def change
    add_column :estudiantes, :monitoria_id, :integer
  end
end
