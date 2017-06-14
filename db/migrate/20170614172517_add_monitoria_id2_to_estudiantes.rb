class AddMonitoriaId2ToEstudiantes < ActiveRecord::Migration[5.0]
  def change
    add_column :estudiantes, :monitoria_id2, :integer
  end
end
